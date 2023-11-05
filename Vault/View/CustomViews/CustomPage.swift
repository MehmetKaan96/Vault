//
//  CustomPage.swift
//  Vault
//
//  Created by Mehmet Kaan on 5.11.2023.
//

import UIKit
import NeonSDK


protocol CustomPageDelegate {
    func backButtonDidTapped()
    func rightButtonDidTapped()
}

class CustomPage: UIView {
    
    var delegate: CustomPageDelegate?

    let pageNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Font.custom(size: 25, fontWeight: .Medium)
        return label
    }()
    
    let contentView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.homecontainercolor
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let backButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        button.configuration = .plain()
        return button
    }()
    
    let rightButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "btn_settings"), for: .normal)
        button.configuration = .plain()
        return button
    }()
    
    init(pageName: String?, rightButtonImage: UIImage?) {
        super.init(frame: .zero)
        guard let name = pageName, let image = rightButtonImage else { return }
        self.pageNameLabel.text = name
        self.rightButton.setImage(image, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        self.backgroundColor = .headercolor
        self.addSubview(pageNameLabel)
        self.addSubview(contentView)
        self.addSubview(backButton)
        self.addSubview(rightButton)
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(23)
            make.top.equalTo(self.snp.top).offset(30)
            make.height.equalTo(24)
        }
        
        rightButton.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-23)
            make.top.equalTo(self.snp.top).offset(30)
            make.height.equalTo(24)
        }
        
        pageNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(30)
            make.left.equalTo(backButton.snp.right).offset(125)
            make.right.equalTo(rightButton.snp.left).offset(-125)
            make.height.equalTo(24)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(pageNameLabel.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview()
        }
        
        setup(pageName: nil, rightButtonImage: nil)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    func setup(pageName: String?, rightButtonImage: UIImage?) {
        guard let name = pageName, let image = rightButtonImage else { return }
        self.pageNameLabel.text = name
        self.rightButton.setImage(image, for: .normal)
    }
    
    @objc func backButtonTapped() {
        delegate?.backButtonDidTapped()
    }
    
    @objc func rightButtonTapped() {
        delegate?.rightButtonDidTapped()
    }
    
}

#Preview() {
    CustomPage(pageName: "Home", rightButtonImage: UIImage(named: "btn_settings"))
}
