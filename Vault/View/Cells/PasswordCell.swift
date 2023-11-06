//
//  PasswordCell.swift
//  Vault
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import UIKit
import NeonSDK

class PasswordCell: NeonTableViewCell<PasswordModel> {

    private let passwordLabel: UILabel = {
       let label = UILabel()
        label.font = Font.custom(size: 20, fontWeight: .Medium)
        label.text = "Apple"
        label.numberOfLines = 0
        return label
    }()
        
    private let passwordImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
            contentView.addSubview(passwordImage)
            contentView.addSubview(passwordLabel)
            
            passwordImage.snp.makeConstraints { make in
                make.left.equalTo(contentView.snp.left).offset(20)
                make.centerY.equalTo(contentView.snp.centerY)
                make.bottom.lessThanOrEqualTo(contentView.snp.bottom)
            }
            
            passwordLabel.snp.makeConstraints { make in
                make.top.equalTo(passwordImage.snp.top).offset(10)
                make.left.equalTo(passwordImage.snp.right).offset(30)
                make.right.equalTo(contentView.snp.right)
                make.centerY.equalTo(contentView.snp.centerY)
            }
        }
    
    override func configure(with object: PasswordModel) {
        super.configure(with: object)
        self.passwordLabel.text = object.account
        self.passwordImage.image = UIImage(data: object.image)
    }

}
