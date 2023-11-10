//
//  PhotosCell.swift
//  Vault
//
//  Created by Mehmet Kaan on 3.11.2023.
//
import UIKit
import NeonSDK

class PhotosCell: NeonCollectionViewCell<PhotoModel> {
    static let identifier =  "photosCell"
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    override func configure(with photo: PhotoModel) {
        super.configure(with: photo)
        imageView.image = UIImage(data: photo.imageData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.right.left.bottom.equalToSuperview()
        }

    }
}

