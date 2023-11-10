//
//  CustomPaywallButton.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import UIKit
import NeonSDK

class CustomPaywallButton: UIButton {
    
     var paywallButtonText1 = UILabel()
     var paywallButtonText2 = UILabel()
     let buttonImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton(with: nil, subText: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton(with: nil, subText: nil)
    }
    
    init(text: String? = nil, subtext: String? = nil) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.isSelected = false
        setupButton(with: text, subText: subtext)
    }
    
    private func setupButton(with text: String?, subText: String?) {
        self.layer.cornerRadius = 10
        
        addSubview(paywallButtonText1)
        paywallButtonText1.font = Font.custom(size: 18, fontWeight: .Regular)
        paywallButtonText1.textAlignment = .center
        paywallButtonText1.textColor = UIColor.black
        
        
        paywallButtonText2.font = Font.custom(size: 18, fontWeight: .Medium)
        paywallButtonText2.textAlignment = .center
        paywallButtonText2.textColor = UIColor.black
        self.addSubview(paywallButtonText2)
        
        buttonImageView.image = UIImage(named: "img_tick")
        buttonImageView.isHidden = true
        buttonImageView.contentMode = .scaleAspectFill
        buttonImageView.clipsToBounds = true
        self.addSubview(buttonImageView)
        buttonImageView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        paywallButtonText1.text = text
        paywallButtonText1.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(buttonImageView.snp.right).offset(13)
        }
        
        paywallButtonText2.text = subText
        paywallButtonText2.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-15)
        }
    }
    
    func setpaywallButtonText2(text: String) {
        self.paywallButtonText2.text = text
    }
    
}

