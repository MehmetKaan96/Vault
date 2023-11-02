//
//  PaywallDeclarations.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import Foundation
import UIKit
import NeonSDK

struct PaywallDeclarations {
    static let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_inapp")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    static let buttonView: UIView = {
        let bv = UIView()
        bv.backgroundColor = .systemGray6
        bv.layer.cornerRadius = 15
        bv.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return bv
    }()
    
    static let upgradeLabel: UILabel = {
        let label = UILabel()
        label.text = "Upgrade to Premium"
        label.font = Font.custom(size: 28, fontWeight: .SemiBold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    static let upgradeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Get premium now and have unlimited safe vault for your private media and info"
        label.font = Font.custom(size: 19, fontWeight: .Regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    static let startButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = Font.custom(size: 16, fontWeight: .Regular)
        return button
    }()
    
    static let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.configuration = .plain()
        button.tintColor = .black
        return button
    }()
}

