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
    
    var isCellUserInteractionEnabled: Bool = true {
            didSet {
                imageView.isUserInteractionEnabled = isCellUserInteractionEnabled
            }
        }
    
    internal let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
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
        contentView.addSubview(imageView)
        
        imageView.layer.cornerRadius = 10
        imageView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top).offset(20)
            make.right.equalTo(contentView.snp.right)
        }

    }
}

