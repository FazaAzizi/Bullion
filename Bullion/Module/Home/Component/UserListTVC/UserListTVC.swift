//
//  UserListTVC.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

class UserListTVC: UITableViewCell {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    static let identifier = String(describing: UserListTVC.self)
    
    static let nib = {
       UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.makeCornerRadius(8)
        containerView.addShadow(2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension UserListTVC {
    func configureCell(data: UserModel){
        nameLbl.text = data.name
        dateLbl.text = formatDateString(data.dateOfBirth)
        emailLbl.text = data.email
        profileImgView.setImage(fromBase64: data.photo)
    }
}
