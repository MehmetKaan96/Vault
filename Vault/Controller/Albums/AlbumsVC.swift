//
//  AlbumsVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import UIKit
import NeonSDK
import CoreData

class AlbumsVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var collectionView: AlbumCollectionView!
    var selectedAlbum: AlbumModel!
    
    
    internal let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Album Name"
        tf.font = Font.custom(size: 16, fontWeight: .Regular)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_add"), for: .normal)
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
        label.text = "Albums"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = Font.custom(size: 25, fontWeight: .Medium)
        return label
    }()
    
    var customView: NoAlbumView!
    
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
        AlbumsVC.fetchFromCoreData()
        view.backgroundColor = .headercolor
        view.addSubview(content)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        
        content.addSubview(saveButton)
        content.addSubview(cancelButton)
        content.addSubview(textField)
        
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
        
        addButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        if albumArray.isEmpty {
            customView = NoAlbumView()
            content.addSubview(customView)
            customView.snp.makeConstraints { make in
                make.centerX.equalTo(content.snp.centerX)
                make.top.equalTo(content.snp.top).offset(100)
            }
        } else {
            print(albumArray)
            collectionView = AlbumCollectionView()
            collectionView.layer.cornerRadius = 10
            collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            content.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
                        self.collectionView.didSelect = { object, indexPath in
                            self.selectedAlbum = albumArray[indexPath.row]
                            let vc = AlbumPhotosVC()
                            vc.selectedAlbum = self.selectedAlbum
                            vc.modalPresentationStyle = .fullScreen
                            self.present(destinationVC: vc, slideDirection: .right)
                        }
        }
        
        createButtonFunctions()
    }
    
    private func createButtonFunctions() {
        backButton.addAction {
            let vc = HomeVC()
            vc.modalPresentationStyle = .fullScreen
            self.dismiss(animated: true)
        }
        
        addButton.addAction {
            if albumArray.isEmpty {
                self.customView.isHidden = true
            } else {
                self.collectionView.isHidden = true
            }
            self.textField.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(150)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(51)
            }
            
            self.saveButton.snp.makeConstraints { make in
                make.top.equalTo(self.textField.snp.bottom).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(51)
                make.width.equalTo(160)
            }
            
            self.cancelButton.snp.makeConstraints { make in
                make.top.equalTo(self.textField.snp.bottom).offset(20)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.height.equalTo(51)
                make.width.equalTo(174)
                make.right.equalTo(self.saveButton.snp.left).offset(-20)
            }
            
            self.saveButton.addAction {
                CoreDataManager.saveData(container: "Vault", entity: "Album", attributeDict: [
                    "name": self.textField.text!,
                ])
            }
        }
    }
}
