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
    func packageFetched() {
        if let monthlyPackage = RevenueCatManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Montly"){
            let price = monthlyPackage.localizedPriceString
            monthlyButton.setButtonText2(text: "\(price)")
        }
        
        if let weeklyPackage = RevenueCatManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Weekly"){
            let price = weeklyPackage.localizedPriceString
            print("Weekly price: \(price)")
        }
        
        if let annualPackage = RevenueCatManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual"){
            let price = annualPackage.localizedPriceString
            print("Annual price: \(price)")
        }
    }
    
    
    let imageView = PaywallDeclarations.imageView
    let buttonView = PaywallDeclarations.buttonView
    let upgradeLabel = PaywallDeclarations.upgradeLabel
    let upgradeTextLabel = PaywallDeclarations.upgradeTextLabel
    let startButton = PaywallDeclarations.startButton
    let closeButton = PaywallDeclarations.closeButton
    let annualButton = CustomPaywallButton(text: "Annual", subtext: "$120.95")
    let monthlyButton = CustomPaywallButton(text: "Monthly", subtext: "$120.95")
    let weeklyButton = CustomPaywallButton(text: "Weekly", subtext: "$120.95")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createUI()
        RevenueCatManager.delegate = self
        packageFetched()
    }
    
    private func createUI() {
        view.backgroundColor = .white
        view.addSubview(buttonView)
        view.addSubview(imageView)
        view.addSubview(closeButton)
        buttonView.addSubview(upgradeLabel)
        buttonView.addSubview(upgradeTextLabel)
        buttonView.addSubview(startButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        let screenHeight = UIScreen.main.bounds.height
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(95)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.lessThanOrEqualTo(imageView.snp.right).offset(30)
            make.height.equalTo(25)
        }
        closeButton.addTarget(self, action: #selector(goToHomeVC), for: .touchUpInside)
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(11)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(view.snp.height).multipliedBy(0.66)
        }
        
        upgradeLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top).offset(25)
            make.left.equalTo(buttonView).offset(55)
            make.right.equalTo(buttonView).offset(-50)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.1)
        }
        
        upgradeTextLabel.snp.makeConstraints { make in
            make.top.equalTo(upgradeLabel.snp.bottom).offset(20)
            make.left.equalTo(buttonView).offset(9)
            make.right.equalTo(buttonView).offset(-8)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.2)
        }
        
        
        buttonView.addSubview(weeklyButton)
        weeklyButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(upgradeTextLabel.snp.bottom).offset(30)
            make.left.equalTo(buttonView.snp.left).offset(30)
            make.right.equalTo(buttonView.snp.right).offset(-30)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.15)
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
        
        buttonView.addSubview(annualButton)
        annualButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(monthlyButton.snp.bottom).offset(30)
            make.left.equalTo(buttonView.snp.left).offset(30)
            make.right.equalTo(buttonView.snp.right).offset(-30)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.15)
        }
        
        startButton.snp.makeConstraints { make in
            //            make.top.equalTo(annualButton.snp.bottom)
            make.left.right.equalToSuperview().inset(120)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(buttonView.snp.width).multipliedBy(0.1)
        }
        
        startButton.addAction {
            RevenueCatManager.selectPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Montly")
            
            RevenueCatManager.purchase(animation: .loadingBar) {
                self.present(destinationVC: HomeVC(), slideDirection: .left)
            } completionFailure: {
                // Couldn't purchase selected package
            }
        }
    }
}
