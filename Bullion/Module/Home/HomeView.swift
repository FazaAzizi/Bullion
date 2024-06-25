// 
//  HomeView.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

class HomeView: UIViewController {
    
    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addUserButton: GeneralButton!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HomePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension HomeView {
    private func setupView() {
        containerView.makeCornerRadius(24, [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.view.applyGradient(colors: [
            UIColor.orangeFiirst,
            UIColor.orangeSecond,
            UIColor.orangeThird
        ])
        addUserButton.configure(title: "Add Users", isEnable: true)
        addUserButton.delegate = self
        

        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        
        setupTableView()
        setupCollectionView()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UserListTVC.nib, forCellReuseIdentifier: UserListTVC.identifier)
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(NewsCVC.nib, forCellWithReuseIdentifier: NewsCVC.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: 320, height: 160)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.collectionViewLayout = layout
    }
}

extension HomeView: GeneralButtonDelegate {
    func didTapButton(_ view: UIView) {
        self.navigationController?.popViewController(animated: false)
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListTVC.identifier, for: indexPath) as? UserListTVC
        else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigation = self.navigationController,
              let presenter
        else {return}
        
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCVC.identifier, for: indexPath) as? NewsCVC
        else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let pageWidth = layout.itemSize.width + layout.minimumLineSpacing
        let offset = scrollView.contentOffset.x + layout.sectionInset.left - 20
        let page = Int(round(offset / pageWidth))
        pageControl.currentPage = page
    }
}
