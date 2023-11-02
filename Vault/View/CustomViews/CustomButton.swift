//
//  CustomButton.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import Foundation
import UIKit
import NeonSDK

class CustomButton: UIButton {
    private let buttonText1 = UILabel()
    private let rightButtonImageView = UIImageView()
    private let leftButtonImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton(with: nil, image1: nil, image2: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(text: String? = nil, image1: UIImage? = nil, image2: UIImage? = nil) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.isSelected = false
        setupButton(with: text, image1: image1, image2: image2)
    }
    
    private func setupButton(with text: String?, image1: UIImage?, image2: UIImage?) {
        self.layer.cornerRadius = 10

        leftButtonImageView.image = image1
        leftButtonImageView.contentMode = .scaleAspectFill
        leftButtonImageView.clipsToBounds = true
        self.addSubview(leftButtonImageView)
        leftButtonImageView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(24)
            make.centerY.equalTo(self.snp.centerY)
        }

        buttonText1.font = Font.custom(size: 18, fontWeight: .Regular)
        buttonText1.textAlignment = .center
        buttonText1.textColor = UIColor.black
        buttonText1.text = text
        self.addSubview(buttonText1)
        buttonText1.snp.makeConstraints { make in
            make.center.equalTo(self)
        }

        rightButtonImageView.image = image2
        rightButtonImageView.contentMode = .scaleAspectFill
        rightButtonImageView.clipsToBounds = true
        self.addSubview(rightButtonImageView)
        rightButtonImageView.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-24)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}

