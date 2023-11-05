//
//  CustomOnboardingView.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import UIKit
import NeonSDK


protocol CustomOnboardingViewDelegate {
    func buttonDidTapped()
}

class CustomOnboardingView: UIView {
    
    var delegate: CustomOnboardingViewDelegate?
    
    let imageView = OnboardDeclarations.imageView
    let label1 = OnboardDeclarations.label1
    let label2 = OnboardDeclarations.label2
    let contentView = OnboardDeclarations.contentView
    let button = OnboardDeclarations.button
    let pageControl = NeonPageControlV2()
    
    init(text: String = "Lock Private Items", subtext: String = "Safely store your private photos, videos, passwords, credit card information and notes in this app.", image: UIImage = UIImage(named: "img_onboarding1")!, title: String = "Next") {
        super.init(frame: .zero)
        self.label1.text = text
        self.label2.text = subtext
        self.imageView.image = image
        self.button.setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with text: String = "Lock Private Items", image:UIImage = UIImage(named: "img_onboarding1")!, subtext: String = "Safely store your private photos, videos, passwords, credit card information and notes in this app.", title: String = "Next") {
        label1.text = text
        label2.text = subtext
        imageView.image = image
        button.setTitle(title, for: .normal)
    }
    
    private func createUI() {
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        self.addSubview(imageView)
        self.addSubview(contentView)
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(button)
        contentView.addSubview(pageControl)
        
        pageControl.numberOfPages = 2
        pageControl.currentPageTintColor = UIColor(red: 0.321, green: 0.492, blue: 0.929, alpha: 1)
        pageControl.tintColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
        pageControl.padding = 10
        
        setup()
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(self.snp.height).multipliedBy(0.45)
        }

        contentView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }

        label1.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(42)
        }

        label2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(81)
        }

        pageControl.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(label2.snp.bottom).offset(57)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(15)
        }

        button.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(pageControl.snp.bottom).offset(65)
            make.leading.trailing.equalToSuperview().inset(120)
            make.bottom.equalTo(self.snp.bottom).inset(49)
            make.height.equalTo(51)
        }
        button.addTarget(self, action: #selector(changePage), for: .touchUpInside)
    }
    
    @objc func changePage() {
        delegate?.buttonDidTapped()
    }
    
}
