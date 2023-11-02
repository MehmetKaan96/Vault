//
//  PaywallExtension.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import Foundation
import NeonSDK

extension PaywallVC {
    @objc func goToHomeVC() {
        let vc = HomeVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(destinationVC: vc, slideDirection: .up)
    }
}
