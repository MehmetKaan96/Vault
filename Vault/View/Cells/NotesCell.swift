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
        label.text = "dkfjsgjkhsdfkgjsdkfjgskdjfgşksdjfhgksjdfhgksjdfngjklsdbfgkjsn"
        label.font = Font.custom(size: 20, fontWeight: .Medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "jkdnfsgkjsnfdglksdnflgnsdlfkgmnsdşlfkgmnsdlfnglsshjfsahjdfgshjfgsjdfgjsdhjfgsdjfgsdjfgsdjfgskdjfhgskj"
        label.font = Font.custom(size: 10, fontWeight: .Light)
        label.numberOfLines = 0
        return label
    }()
    
    private let noteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
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
            addSubview(noteImage)
            addSubview(titleLabel)
            addSubview(descriptionLabel)
            
            noteImage.snp.makeConstraints { make in
                make.left.equalTo(contentView.snp.left).offset(30)
                make.top.equalTo(contentView.snp.top).offset(10)
                make.bottom.equalTo(contentView.snp.bottom)
                make.right.equalToSuperview().inset(300)
//                make.height.equalTo(50)
//                make.width.equalTo(50)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(noteImage.snp.top).offset(10)
                make.left.equalTo(noteImage.snp.right).offset(10)
                make.right.equalTo(contentView.snp.right)
                make.height.equalTo(60)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.left.equalTo(noteImage.snp.right).offset(10)
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

#Preview() {
    NotesCell()
}
