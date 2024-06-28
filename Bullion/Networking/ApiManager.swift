//
//  ApiManager.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import Alamofire
import Combine

enum ErrorHandler: Error {
    case failedParsing
    case unknownError
    case dataEmpty
    case unauthorized
}

class ApiManager {
    
    private static let session: Session = {
        let evaluator: [String: ServerTrustEvaluating] = [
            "api-test.bullionecosystem.com": DisabledTrustEvaluator()
        ]
        let manager = ServerTrustManager(evaluators: evaluator)
        let session = Session(serverTrustManager: manager)
        return session
    }()
    
    func requestApiPublisherNew<T: Codable>(_ endpoint: Endpoint, timeout: TimeInterval = 60) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            Task {
                do {
                    print("DIGI-HEADER: \(endpoint.header)")
                    print("DIGI-URL: \(endpoint.method().rawValue)")
                    print("DIGI-PARAMS: \(endpoint.parameter ?? [:])")
                    
                    let result: T = try await withUnsafeThrowingContinuation({ continuation in
                        ApiManager.session.request(
                            endpoint.urlString(),
                            method: endpoint.method(),
                            parameters: endpoint.parameter,
                            encoding: JSONEncoding.default,
                            headers: endpoint.header,
                            interceptor: nil,
                            requestModifier: { $0.timeoutInterval = timeout })
                        .responseData(
                            queue: .main,
                            dataPreprocessor: DataResponseSerializer.defaultDataPreprocessor,
                            emptyResponseCodes: [200, 401],
                            emptyRequestMethods: DataResponseSerializer.defaultEmptyRequestMethods) { response in
                                if let error = response.error {
                                    print(error)
                                    continuation.resume(throwing: error)
                                } else {
                                    guard let urlResponse = response.response else {
                                        print("invalid urlResponse")
                                        continuation.resume(throwing: ErrorHandler.unknownError)
                                        return
                                    }
                                    switch urlResponse.statusCode {
                                    case 401:
                                        print("Unauthorized")
                                        continuation.resume(throwing: ErrorHandler.unauthorized)
                                    default:
                                        if let data = response.data {
                                            do {
                                                let decoded = try JSONDecoder().decode(T.self, from: data)
                                                print(decoded)
                                                continuation.resume(returning: decoded)
                                            } catch {
                                                print(error)
                                                continuation.resume(throwing: error)
                                            }
                                        } else {
                                            continuation.resume(throwing: ErrorHandler.unknownError)
                                        }
                                    }
                                }
                            }
                    })
                    
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func requestApiPublisher<T: Codable>(_ endpoint: Endpoint, timeout: TimeInterval = 60, isHaveFile: Bool = false) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            Task {
                do {
                    let result: T = try await withUnsafeThrowingContinuation({ continuation in
                        if isHaveFile {
                            if let data = endpoint.data() as? UserModel
                            {
                                AF.upload(multipartFormData: { multipartFormData in
                                    if let parameters = endpoint.parameter {
                                        for (key, value) in parameters {
                                            if let stringValue = value as? String {
                                                multipartFormData.append(Data(stringValue.utf8), withName: key)
                                            }
                                        }
                                    }
                                    
                                    if let imageData = Data(base64Encoded: data.photo), let image = UIImage(data: imageData) {
                                        multipartFormData.append(imageData, withName: "photo", fileName: "user-avatar.png", mimeType: "image/png")
                                    } else {
                                        print("Failed to convert base64 string to Data or UIImage.")
                                    }
                                    
                                },
                                          to: endpoint.urlString(),
                                          headers: endpoint.header
                                )
                                .responseData(queue: .main) { response in
                                    self.handleResponse(response: response, continuation: continuation)
                                }
                            }
                        } else {
                            ApiManager.session.request(
                                endpoint.urlString(),
                                method: endpoint.method(),
                                parameters: endpoint.parameter,
                                encoding: JSONEncoding.default,
                                headers: endpoint.header,
                                interceptor: nil,
                                requestModifier: { $0.timeoutInterval = timeout }
                            )
                            .responseData(
                                queue: .main,
                                dataPreprocessor: DataResponseSerializer.defaultDataPreprocessor,
                                emptyResponseCodes: [200, 401],
                                emptyRequestMethods: DataResponseSerializer.defaultEmptyRequestMethods) { response in
                                    if let error = response.error {
                                        continuation.resume(throwing: error)
                                    } else {
                                        guard let urlResponse = response.response else {
                                            continuation.resume(throwing: ErrorHandler.unknownError)
                                            return
                                        }
                                        switch urlResponse.statusCode {
                                        case 401:
                                            continuation.resume(throwing: ErrorHandler.unauthorized)
                                        default:
                                            if let data = response.data {
                                                do {
                                                    let decoded = try JSONDecoder().decode(T.self, from: data)
                                                    continuation.resume(returning: decoded)
                                                } catch {
                                                    continuation.resume(throwing: error)
                                                }
                                            } else {
                                                continuation.resume(throwing: ErrorHandler.unknownError)
                                            }
                                        }
                                    }
                                }
                        }
                    })
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    
    private func handleResponse<T: Codable>(response: AFDataResponse<Data>, continuation: UnsafeContinuation<T, Error>) {
        if let error = response.error {
            continuation.resume(throwing: error)
        } else {
            guard let urlResponse = response.response else {
                continuation.resume(throwing: ErrorHandler.unknownError)
                return
            }
            switch urlResponse.statusCode {
            case 401:
                continuation.resume(throwing: ErrorHandler.unauthorized)
            default:
                if let data = response.data {
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        continuation.resume(returning: decoded)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                } else {
                    continuation.resume(throwing: ErrorHandler.unknownError)
                }
            }
        }
    }
}



