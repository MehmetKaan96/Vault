//
//  CustomPaywallButton.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import UIKit
import NeonSDK

class CustomPaywallButton: UIButton {
    
    private let buttonText1 = UILabel()
    private let buttonText2 = UILabel()
    private let buttonImageView = UIImageView()
    
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
                
        buttonText1.font = Font.custom(size: 18, fontWeight: .Regular)
        buttonText1.textAlignment = .center
        buttonText1.textColor = UIColor.black
        self.addSubview(buttonText1)
        
        buttonText2.font = Font.custom(size: 18, fontWeight: .Medium)
        buttonText2.textAlignment = .center
        buttonText2.textColor = UIColor.black
        self.addSubview(buttonText2)
        
        buttonImageView.image = UIImage(named: "img_tick")
        buttonImageView.isHidden = true
        buttonImageView.contentMode = .scaleAspectFill
        buttonImageView.clipsToBounds = true
        self.addSubview(buttonImageView)
        buttonImageView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        buttonText1.text = text
        buttonText1.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(buttonImageView.snp.right).offset(13)
        }
        
        buttonText2.text = subText
        buttonText2.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-15)
        }
    }
    
}

