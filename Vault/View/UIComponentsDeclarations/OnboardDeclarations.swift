//
//  OnboardDeclarations.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import Foundation
import UIKit
import NeonSDK

struct OnboardDeclarations {
    static let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    static let label1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.379, green: 0.379, blue: 0.379, alpha: 1)
        label.font = Font.custom(size: 28, fontWeight: .SemiBold)
        return label
    }()
    
    static let label2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.379, green: 0.379, blue: 0.379, alpha: 1)
        label.font = Font.custom(size: 18, fontWeight: .Regular)
        return label
    }()
    
    static let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    static let button: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.setTitle("Next", for: .normal)
        return button
    }()
}
