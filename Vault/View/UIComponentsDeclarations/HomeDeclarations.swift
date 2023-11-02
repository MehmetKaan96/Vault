//
//  HomeDeclarations.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import Foundation
import UIKit
import NeonSDK

struct HomeDeclarations {
    static let headerTitle: UILabel = {
        let label = UILabel()
        label.font = Font.custom(size: 25, fontWeight: .Medium)
        label.text = "Home"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    static let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_settings"), for: .normal)
        button.tintColor = .white
        button.configuration = .plain()
        return button
    }()
    
    static let homeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    static let infoView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    static let imageView: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "img_safeVault")
        return iv
    }()
}

