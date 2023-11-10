//
//  OnboardingVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

//REvenueccat'i ayarla,
//custompage oluştur.
//çoklu silme
//password filtreme'
//dissmiss yapılmadan fotoğraf ve albumleri görüntüleme
//Premium olmadan sınırlama


import UIKit
import NeonSDK

class OnboardingVC: UIViewController {

    var customVC: CustomOnboardingView!
    var didTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createUI()
    }
    
    private func createUI() {
        view.backgroundColor = .white
        customVC = CustomOnboardingView()
        customVC.delegate = self
        view.addSubview(customVC)
    }

}

extension OnboardingVC: CustomOnboardingViewDelegate {
    func onboardingButtonDidTapped() {
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
