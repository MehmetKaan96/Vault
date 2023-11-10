//
//  SettingsVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import UIKit
import NeonSDK

class SettingsVC: UIViewController {
    let tryPremiumButton = CustomButton(text: "Try Premium", image1: UIImage(named: "img_premium"), image2: UIImage(named: "btn_arrow_right_gray"))
    let contactUsButton = CustomButton(text: "Contact Us", image1: UIImage(named: "img_contact"), image2: UIImage(named: "btn_arrow_right_gray"))
    let rateUsButton = CustomButton(text: "Rate Us", image1: UIImage(named: "img_rate"), image2: UIImage(named: "btn_arrow_right_gray"))
    let privacyPolicyButton = CustomButton(text: "Privacy Policy", image1: UIImage(named: "img_privacy"), image2: UIImage(named: "btn_arrow_right_gray"))
    let termsOfUseButton = CustomButton(text: "Terms Of Use", image1: UIImage(named: "img_termsofuse"), image2: UIImage(named: "btn_arrow_right_gray"))

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Neon.isUserPremium)
        createUI()
    }
    
    private func createUI() {
        view.backgroundColor = .headercolor
        
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = Font.custom(size: 25, fontWeight: .Medium)
        view.addSubview(titleLabel)
        
        let homeView = UIView()
        homeView.backgroundColor = .homecontainercolor
        homeView.layer.cornerRadius = 15
        homeView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(homeView)
        
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "btn_back"), for: .normal)
        backButton.backgroundColor = .clear
        view.addSubview(backButton)
        
        if Neon.isUserPremium {
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

            homeView.addSubview(contactUsButton)
            homeView.addSubview(rateUsButton)
            homeView.addSubview(privacyPolicyButton)
            homeView.addSubview(termsOfUseButton)
            
            contactUsButton.snp.makeConstraints { make in
                make.top.equalTo(homeView).offset(50)
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
        } else {
            
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
        }
        
        backButton.addAction {
            self.dismiss(animated: true)
        }
        
        tryPremiumButton.addAction {
            let vc = PaywallVC()
            self.present(destinationVC: vc, slideDirection: .left)
        }
        
        contactUsButton.addAction {
            UIApplication.shared.open(URL(string: "www.neonapps.co")!)
        }
        
        rateUsButton.addAction {
            UIApplication.shared.open(URL(string: "www.neonapps.co")!)
        }
        
        privacyPolicyButton.addAction {
            UIApplication.shared.open(URL(string: "https://www.neonapps.co/privacy-policy")!)
        }
        
        termsOfUseButton.addAction {
            UIApplication.shared.open(URL(string: "https://www.neonapps.co/terms-of-use")!)
        }
    }
    
    
}
