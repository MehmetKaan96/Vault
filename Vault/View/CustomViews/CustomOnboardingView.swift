//
//  CustomOnboardingView.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import UIKit
import NeonSDK


protocol CustomOnboardingViewDelegate {
    func onboardingButtonDidTapped()
}

class CustomOnboardingView: UIView {
    
    var delegate: CustomOnboardingViewDelegate?
    
    let imageView = UIImageView()
    let onboardLabel1 = UILabel()
    let onboardingLabel2 = UILabel()
    let contentView = UIView()
    let onboardingButton = UIButton()
    let pageControl = NeonPageControlV2()
    
    init(text: String = "Lock Private Items", subtext: String = "Safely store your private photos, videos, passwords, credit card information and notes in this app.", image: UIImage = UIImage(named: "img_onboarding1")!, title: String = "Next") {
        super.init(frame: .zero)
        self.onboardLabel1.text = text
        self.onboardingLabel2.text = subtext
        self.imageView.image = image
        self.onboardingButton.setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with text: String = "Lock Private Items", image:UIImage = UIImage(named: "img_onboarding1")!, subtext: String = "Safely store your private photos, videos, passwords, credit card information and notes in this app.", title: String = "Next") {
        onboardLabel1.text = text
        onboardingLabel2.text = subtext
        imageView.image = image
        onboardingButton.setTitle(title, for: .normal)
    }
    
    private func createUI() {
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        setup()
        
        self.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(self.snp.height).multipliedBy(0.45)
        }

        contentView.backgroundColor = .homecontainercolor
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }

        contentView.addSubview(onboardLabel1)
        onboardLabel1.numberOfLines = 0
        onboardLabel1.textAlignment = .center
        onboardLabel1.textColor = UIColor(red: 0.379, green: 0.379, blue: 0.379, alpha: 1)
        onboardLabel1.font = Font.custom(size: 28, fontWeight: .SemiBold)
        contentView.addSubview(onboardLabel1)
        onboardLabel1.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(42)
        }

        onboardingLabel2.numberOfLines = 0
        onboardingLabel2.textAlignment = .center
        onboardingLabel2.textColor = UIColor(red: 0.379, green: 0.379, blue: 0.379, alpha: 1)
        onboardingLabel2.font = Font.custom(size: 18, fontWeight: .Regular)
        contentView.addSubview(onboardingLabel2)
        onboardingLabel2.snp.makeConstraints { make in
            make.top.equalTo(onboardLabel1.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(81)
        }

        contentView.addSubview(pageControl)
        pageControl.numberOfPages = 2
        pageControl.currentPageTintColor = UIColor(red: 0.321, green: 0.492, blue: 0.929, alpha: 1)
        pageControl.tintColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
        pageControl.padding = 10
        pageControl.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(onboardingLabel2.snp.bottom).offset(57)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(15)
        }

        onboardingButton.configuration = .filled()
        onboardingButton.setTitle("Next", for: .normal)
        contentView.addSubview(onboardingButton)
        onboardingButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(pageControl.snp.bottom).offset(65)
            make.leading.trailing.equalToSuperview().inset(120)
            make.bottom.equalTo(self.snp.bottom).inset(49)
            make.height.equalTo(51)
        }
        onboardingButton.addAction { [self] in
            delegate?.onboardingButtonDidTapped()
        }
    }
}
