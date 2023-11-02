//
//  SettingsVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import UIKit
import NeonSDK

class SettingsVC: UIViewController {
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Settings"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = Font.custom(size: 25, fontWeight: .Medium)
        return label
    }()
    
    private let homeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private let backButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private let tryPremiumButton = CustomButton(text: "Try Premium", image1: UIImage(named: "img_premium"), image2: UIImage(named: "btn_arrow_right_gray"))
    private let contactUsButton = CustomButton(text: "Contact Us", image1: UIImage(named: "img_contact"), image2: UIImage(named: "btn_arrow_right_gray"))
    private let rateUsButton = CustomButton(text: "Rate Us", image1: UIImage(named: "img_rate"), image2: UIImage(named: "btn_arrow_right_gray"))
    private let privacyPolicyButton = CustomButton(text: "Privacy Policy", image1: UIImage(named: "img_privacy"), image2: UIImage(named: "btn_arrow_right_gray"))
    private let termsOfUseButton = CustomButton(text: "Terms Of Use", image1: UIImage(named: "img_termsofuse"), image2: UIImage(named: "btn_arrow_right_gray"))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createUI()
    }
    
    private func createUI() {
        view.backgroundColor = UIColor(red: 0.321, green: 0.492, blue: 0.929, alpha: 1)
        view.addSubview(titleLabel)
        view.addSubview(homeView)
        view.addSubview(backButton)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            make.left.equalTo(view.snp.left).offset(30)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalTo(titleLabel.snp.left).offset(-(view.frame.width - 300))
        }

        homeView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        homeView.addSubview(tryPremiumButton)
        homeView.addSubview(contactUsButton)
        homeView.addSubview(rateUsButton)
        homeView.addSubview(privacyPolicyButton)
        homeView.addSubview(termsOfUseButton)
        
        
        tryPremiumButton.snp.makeConstraints { make in
            make.top.equalTo(homeView).offset(50)
            make.left.right.equalTo(homeView)
            make.height.equalTo(51)
        }
        
        contactUsButton.snp.makeConstraints { make in
            make.top.equalTo(tryPremiumButton.snp.bottom).offset(15)
            make.left.right.equalTo(homeView)
            make.height.equalTo(51)
        }
        
        rateUsButton.snp.makeConstraints { make in
            make.top.equalTo(contactUsButton.snp.bottom).offset(15)
            make.left.right.equalTo(homeView)
            make.height.equalTo(51)
        }
        
        privacyPolicyButton.snp.makeConstraints { make in
            make.top.equalTo(rateUsButton.snp.bottom).offset(15)
            make.left.right.equalTo(homeView)
            make.height.equalTo(51)
        }
        
        termsOfUseButton.snp.makeConstraints { make in
            make.top.equalTo(privacyPolicyButton.snp.bottom).offset(15)
            make.left.right.equalTo(homeView)
            make.height.equalTo(51)
        }
        
        backButton.addAction {
            self.dismiss(animated: true)
        }
    }
    
    
}
