//
//  NoAlbumView.swift
//  Vault
//
//  Created by Mehmet Kaan on 1.11.2023.
//

import Foundation
import UIKit
import NeonSDK

class NoView: UIView {
    private let label1: UILabel = {
        let label = UILabel()
        label.text = "There is no albums"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Font.custom(size: 18, fontWeight: .Medium)
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "You don't have any albums yet"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Font.custom(size: 14, fontWeight: .Regular)
        return label
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "img_folder")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    init(text: String, description: String, image: String) {
        super.init(frame: .zero)
        self.imageView.image = UIImage(named: image)
        self.label1.text = text
        self.label2.text = description
        createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createUI() {
        self.addSubview(imageView)
        self.addSubview(label1)
        self.addSubview(label2)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.equalTo(100)
        }
        
        label1.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        label2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}
