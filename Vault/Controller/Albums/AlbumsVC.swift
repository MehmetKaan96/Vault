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
    let textField = UITextField()
    let saveButton = UIButton()
    let cancelButton = UIButton()
    let addButton = UIButton()
    let backButton = UIButton()
    let titleLabel = UILabel()
    var customView: NoView!
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        collectionView.objects = albumArray
    //        collectionView.reloadData()
    //    }
    
    private func createUI() {
        fetchFromCoreData()
        view.backgroundColor = .headercolor
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(79)
            make.left.right.bottom.equalToSuperview()
        }
        
        backButton.setImage(UIImage(named: "btn_back"), for: .normal)
        backButton.configuration = .plain()
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        titleLabel.text = "Albums"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = Font.custom(size: 25, fontWeight: .Medium)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(110)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerY.equalTo(backButton.snp.centerY)
        }
        
        addButton.setImage(UIImage(named: "btn_add"), for: .normal)
        addButton.configuration = .plain()
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        if albumArray.isEmpty {
            customView = NoView(text: "There is No Albums", description: "You don't have any albums yet", image: "img_folder")
            contentView.addSubview(customView)
            customView.snp.makeConstraints { make in
                make.centerX.equalTo(contentView.snp.centerX)
                make.top.equalTo(contentView.snp.top).offset(100)
            }
        } else {
            print(albumArray)
            collectionView = AlbumCollectionView()
            collectionView.layer.cornerRadius = 10
            collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            contentView.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            self.collectionView.didSelect = { object, indexPath in
                self.selectedAlbum = albumArray[indexPath.row]
                let vc = AlbumPhotosVC()
                vc.selectedAlbumID = self.selectedAlbum.id
                self.present(destinationVC: vc, slideDirection: .right)
            }
        }
        backButton.addAction {
            let vc = HomeVC()
            vc.modalPresentationStyle = .fullScreen
            self.dismiss(animated: true)
        }
        addButton.addAction { [self] in
            if albumArray.isEmpty {
                self.customView.isHidden = true
            } else {
                self.collectionView.isHidden = true
            }
            
            contentView.addSubview(textField)
            textField.placeholder = "Album Name"
            textField.font = Font.custom(size: 16, fontWeight: .Regular)
            textField.borderStyle = .roundedRect
            self.textField.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(150)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(51)
            }
            
            saveButton.setTitle("Save", for: .normal)
            saveButton.backgroundColor = .systemBlue
            saveButton.layer.cornerRadius = 10
            saveButton.setTitleColor(.white, for: .normal)
            contentView.addSubview(saveButton)
            self.saveButton.snp.makeConstraints { make in
                make.top.equalTo(self.textField.snp.bottom).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(51)
                make.width.equalTo(160)
            }
            
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.backgroundColor = .white
            cancelButton.layer.cornerRadius = 10
            cancelButton.setTitleColor(.black, for: .normal)
            contentView.addSubview(cancelButton)
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
                    "id": UUID()
                ])
                self.dismiss(animated: true)
            }
            
            self.cancelButton.addAction {
                self.dismiss(animated: true)
            }
        }
    }
    
}

extension AlbumsVC {
    func fetchFromCoreData() {
        albumArray.removeAll(keepingCapacity: false)
        photoArray.removeAll(keepingCapacity: false)
        photoArray.append(PhotoModel(id: UUID(), imageData: (UIImage(named: "addingbtn")?.pngData())!, selected_album_id: UUID()))
        CoreDataManager.fetchDatas(container: "Vault", entity: "Album") { data in
            if let name = data.value(forKey: "name") as? String, let id = data.value(forKey: "id") as? UUID{
                var photos: [PhotoModel] = []
                CoreDataManager.fetchImages(with: id) { data in
                    if let images = data.value(forKey: "imageData") as? Data, let id = data.value(forKey: "id") as? UUID, let album_id = data.value(forKey: "selected_album_id") as? UUID {
                        photos.append(PhotoModel(id: id, imageData: images, selected_album_id: album_id))
                    }
                }
                albumArray.append(AlbumModel(id: id, name: name, images: photos))
            }
        }
    }
}
