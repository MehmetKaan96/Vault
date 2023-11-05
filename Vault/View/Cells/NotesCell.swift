//
//  NotesCell.swift
//  Vault
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import UIKit
import NeonSDK

class NotesCell: NeonTableViewCell<NoteModel> {
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = Font.custom(size: 20, fontWeight: .Medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = Font.custom(size: 10, fontWeight: .Light)
        label.numberOfLines = 0
        return label
    }()
    
    private let noteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "img_notes")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
            contentView.addSubview(noteImage)
            contentView.addSubview(titleLabel)
            contentView.addSubview(descriptionLabel)
            
            noteImage.snp.makeConstraints { make in
                make.left.equalTo(contentView.snp.left)
                make.top.equalTo(contentView.snp.top).inset(10)
                make.bottom.lessThanOrEqualTo(contentView.snp.bottom).inset(10)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(noteImage.snp.top).offset(10)
                make.left.equalTo(noteImage.snp.right).offset(30)
                make.right.equalTo(contentView.snp.right)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.left.equalTo(noteImage.snp.right).offset(30)
                make.right.equalTo(contentView.snp.right)
                make.bottom.lessThanOrEqualTo(contentView.snp.bottom).inset(10)
            }
        }
    
    override func configure(with object: NoteModel) {
        super.configure(with: object)
        self.descriptionLabel.text = object.description
        self.titleLabel.text = object.title
    }
}
