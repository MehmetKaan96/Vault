//
//  AlbumPhotosVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 3.11.2023.
//

import UIKit
import NeonSDK
import PhotosUI

class AlbumPhotosVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedAlbum: AlbumModel!
    var collectionView: PhotoCollectionView!
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_delete"), for: .normal)
        button.configuration = .plain()
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        button.configuration = .plain()
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = Font.custom(size: 25, fontWeight: .Medium)
        return label
    }()
    
    private let content: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    private func createUI() {
        view.backgroundColor = .headercolor
        view.addSubview(content)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(deleteButton)
        
        
        content.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(79)
            make.left.right.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(110)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerY.equalTo(backButton.snp.centerY)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        collectionView = PhotoCollectionView()
        collectionView.layer.cornerRadius = 10
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        content.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.didSelect = { object, indexPath in
            if indexPath.row == 0 && indexPath.section == 0 {
                self.selectImage()
            }
        }
        
        createFunctions()
    }
    
    func createFunctions() {
        backButton.addAction {
            self.dismiss(animated: true)
        }
        
    }
    
    func selectImage() {
        var configuration = PHPickerConfiguration()
                configuration.filter = .images
        configuration.selectionLimit = 10
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                present(picker, animated: true, completion: nil)
    }
}
