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
    
    internal let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    internal let albumLabel: UILabel = {
       let label = UILabel()
        label.font = Font.custom(size: 16, fontWeight: .Medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    internal let photoCountLabel: UILabel = {
       let label = UILabel()
        label.font = Font.custom(size: 12, fontWeight: .Regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    override func configure(with album: AlbumModel) {
        super.configure(with: album)
        if let data = album.images.last?.imageData {
            imageView.image = UIImage(data: data)
        }
        self.albumLabel.text = album.name
        self.photoCountLabel.text = "\(album.images.count - 1) photo(s)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(albumLabel)
        contentView.addSubview(photoCountLabel)
        
        imageView.layer.cornerRadius = 10
        imageView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top)
            make.right.equalTo(contentView.snp.right)
        }
        
        albumLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.left.equalTo(imageView.snp.left).offset(25)
            make.right.equalTo(imageView.snp.right).offset(-25)
        }
        
        photoCountLabel.snp.makeConstraints { make in
            make.top.equalTo(albumLabel.snp.bottom).offset(3)
            make.left.equalTo(imageView.snp.left).offset(32)
            make.right.equalTo(imageView.snp.right).offset(-32)
        }
    }
}

