//
//  OnboardingVCExtension.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import Foundation
import UIKit
import NeonSDK

extension OnboardingVC: CustomOnboardingViewDelegate {
    func buttonDidTapped() {
        if !didTapped {
            customVC.setup(with: "Browse Secretly", image: UIImage(named: "img_onboarding2")!, subtext: "With Private browser, you can surf the Internet privately and your browser history never saved.", title: "Next")
            customVC.pageControl.set(progress: 1, animated: true)
            didTapped = true
        } else {
            Neon.onboardingCompleted()
            let vc = PaywallVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}
