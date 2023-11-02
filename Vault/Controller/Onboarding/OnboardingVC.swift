//
//  OnboardingVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import UIKit

class OnboardingVC: UIViewController {

    var customVC: CustomOnboardingView!
    var didTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createUI()
        print("Deneme")
    }
    
    private func createUI() {
        view.backgroundColor = .white
        customVC = CustomOnboardingView()
        customVC.delegate = self
        view.addSubview(customVC)
    }

}
