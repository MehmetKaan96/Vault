//
//  PaywallVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

//MARK: - paywall butonlarının seçilme işlemini yap.
//MARK: - RevenueCat ile birleştir.

import UIKit
import NeonSDK

class PaywallVC: UIViewController, RevenueCatManagerDelegate {
    let imageView = UIImageView()
    let buttonView = UIView()
    let upgradeLabel = UILabel()
    let upgradeTextLabel = UILabel()
    let startButton = UIButton()
    let closeButton = UIButton()
    let annualButton = CustomPaywallButton(text: "Annual", subtext: "")
    let monthlyButton = CustomPaywallButton(text: "Monthly", subtext: "")
    let weeklyButton = CustomPaywallButton(text: "Weekly", subtext: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        RevenueCatManager.delegate = self
        packageFetched()
    }
    
    private func createUI() {
        view.backgroundColor = .white
        
        imageView.image = UIImage(named: "img_inapp")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(95)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        
        closeButton.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        closeButton.configuration = .plain()
        closeButton.tintColor = .black
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.lessThanOrEqualTo(imageView.snp.right).offset(30)
            make.height.equalTo(25)
        }
        closeButton.addAction {
            let vc = HomeVC()
            self.present(destinationVC: vc, slideDirection: .right)
        }
        
        buttonView.backgroundColor = .systemGray6
        buttonView.layer.cornerRadius = 15
        buttonView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(buttonView)
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(11)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(view.snp.height).multipliedBy(0.66)
        }
        
        
        upgradeLabel.text = "Upgrade to Premium"
        upgradeLabel.font = Font.custom(size: 28, fontWeight: .SemiBold)
        upgradeLabel.numberOfLines = 0
        upgradeLabel.textAlignment = .center
        buttonView.addSubview(upgradeLabel)
        upgradeLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top).offset(25)
            make.left.equalTo(buttonView).offset(55)
            make.right.equalTo(buttonView).offset(-50)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.1)
        }
        
        upgradeTextLabel.text = "Get premium now and have unlimited safe vault for your private media and info"
        upgradeTextLabel.font = Font.custom(size: 19, fontWeight: .Regular)
        upgradeTextLabel.numberOfLines = 0
        upgradeTextLabel.textAlignment = .center
        buttonView.addSubview(upgradeTextLabel)
        upgradeTextLabel.snp.makeConstraints { make in
            make.top.equalTo(upgradeLabel.snp.bottom).offset(20)
            make.left.equalTo(buttonView).offset(9)
            make.right.equalTo(buttonView).offset(-8)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.2)
        }
        
        
        buttonView.addSubview(weeklyButton)
        weeklyButton.addAction {
            
            RevenueCatManager.selectPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Weekly")
        }
        
        weeklyButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(upgradeTextLabel.snp.bottom).offset(30)
            make.left.equalTo(buttonView.snp.left).offset(30)
            make.right.equalTo(buttonView.snp.right).offset(-30)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.15)
        }
        
        monthlyButton.addAction {
            RevenueCatManager.selectPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Montly")
        }
        
        buttonView.addSubview(monthlyButton)
        monthlyButton.isSelected = true
        monthlyButton.layer.borderWidth = 1
        monthlyButton.layer.borderColor = UIColor.systemBlue.cgColor
        monthlyButton.buttonImageView.isHidden = false
        monthlyButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(weeklyButton.snp.bottom).offset(30)
            make.left.equalTo(buttonView.snp.left).offset(30)
            make.right.equalTo(buttonView.snp.right).offset(-30)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.15)
        }
        annualButton.addAction {
            
            RevenueCatManager.selectPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual")
        }
        
        buttonView.addSubview(annualButton)
        annualButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(monthlyButton.snp.bottom).offset(30)
            make.left.equalTo(buttonView.snp.left).offset(30)
            make.right.equalTo(buttonView.snp.right).offset(-30)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.15)
        }
        
        startButton.configuration = .filled()
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = Font.custom(size: 16, fontWeight: .Regular)
        buttonView.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            //            make.top.equalTo(annualButton.snp.bottom)
            make.left.right.equalToSuperview().inset(120)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.1)
        }
        
        startButton.addAction {
           
            RevenueCatManager.purchase(animation: .loadingBar) {
                self.present(destinationVC: HomeVC(), slideDirection: .left)
                Neon.activatePremiumTest()
            } completionFailure: {
                // Couldn't purchase selected package
            }
        }
        
    }
    
    func packageFetched() {
        if let monthlyPackage = RevenueCatManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Montly"){
            let price = monthlyPackage.localizedPriceString
            print("monthlyPackage price: \(price)")
            monthlyButton.paywallButtonText2.text = price
        }
        
        if let weeklyPackage = RevenueCatManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Weekly"){
            let price = weeklyPackage.localizedPriceString
            print("Weekly price: \(price)")
            weeklyButton.paywallButtonText2.text = price
        }
        
        if let annualPackage = RevenueCatManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual"){
            let price = annualPackage.localizedPriceString
            print("Annual price: \(price)")
            annualButton.paywallButtonText2.text = price
        }
    }
}
