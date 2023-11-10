//
//  AlbumCell.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import UIKit
import NeonSDK

class AlbumCell: NeonCollectionViewCell<AlbumModel> {
    
    static let identifier =  "albumcell"
    
    let imageView = UIImageView()
    let albumLabel = UILabel()
    let photoCountLabel =  UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    // MARK: - Configure Cell
    override func configure(with album: AlbumModel) {
        super.configure(with: album)
        if let data = album.images?.last?.imageData {
            imageView.image = UIImage(data: data)
        }
        self.albumLabel.text = album.name
        self.photoCountLabel.text = "\((album.images!.count)) photo(s)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupView
    private func setupSubViews() {
        
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        imageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.right.equalTo(contentView.snp.right)
        }
        
        contentView.addSubview(albumLabel)
        albumLabel.font = Font.custom(size: 16, fontWeight: .Medium)
        albumLabel.textAlignment = .center
        albumLabel.numberOfLines = 0
        albumLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.left.equalTo(imageView.snp.left).offset(20)
            make.right.equalTo(imageView.snp.right).offset(-20)
        }
        
        contentView.addSubview(photoCountLabel)
        photoCountLabel.font = Font.custom(size: 12, fontWeight: .Regular)
        photoCountLabel.textAlignment = .center
        photoCountLabel.numberOfLines = 0
        photoCountLabel.snp.makeConstraints { make in
            make.top.equalTo(albumLabel.snp.bottom).offset(3)
            make.left.equalTo(imageView.snp.left).offset(32)
            make.right.equalTo(imageView.snp.right).offset(-32)
        }
    }
}

