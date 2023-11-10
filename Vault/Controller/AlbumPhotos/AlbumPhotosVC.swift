//
//  AlbumPhotosVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 3.11.2023.
//

import UIKit
import NeonSDK
import PhotosUI
import CoreData

class AlbumPhotosVC: UIViewController {
    var selectedAlbumID: UUID!
    var collectionView: PhotoCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.objects = photoArray
    }
    
    private func createUI() {
        fetchImages()
        view.backgroundColor = .headercolor

        
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(79)
            make.left.right.bottom.equalToSuperview()
        }
        
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "btn_back"), for: .normal)
        backButton.configuration = .plain()
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Photos"
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
        
        var deleteButton = UIButton()
        deleteButton.setImage(UIImage(named: "btn_delete"), for: .normal)
        deleteButton.configuration = .plain()
        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        collectionView = PhotoCollectionView()
        collectionView.layer.cornerRadius = 10
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.bottom.equalToSuperview()
        }
        
        collectionView.didSelect = { object, indexPath in
            if indexPath.row == 0 && indexPath.section == 0 {
                self.selectImage()
            }
        }
        
        collectionView.contextMenuActions = [
            ContextMenuAction(title: "Delete", imageSystemName: "trash", isDestructive: true, action: { object, indexPath in
                let id = photoArray[indexPath.row].id
                CoreDataManager.deleteData(container: "Vault", entity: "Photo", searchKey: "id", searchValue: "\(id)")
                photoArray.remove(at: indexPath.row)
                self.collectionView.objects = photoArray
                if photoArray.count == 1 {
                    self.dismiss(animated: true)
                }
            })]
        
        backButton.addAction {
            self.dismiss(animated: true)
        }
        
        deleteButton.addAction {
            self.collectionView.allowsSelection = true
            self.collectionView.allowsMultipleSelection = true
            
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

extension AlbumPhotosVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        for result in results {
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                    if let error = error {
                        print("Error loading image: \(error)")
                    } else if let url = url {
                        if let imageData = try? Data(contentsOf: url) {
                            self.saveImageToCoreData(imageData, albumID: self.selectedAlbumID)
                        }
                    }
                }
            }
    }
    
    func fetchImages() {
        photoArray.removeAll(keepingCapacity: false)
        photoArray.append(PhotoModel(id: UUID(), imageData: (UIImage(named: "addingbtn")?.pngData())!, selected_album_id: UUID()))
        CoreDataManager.fetchImages(with: selectedAlbumID) { data in
            if let id = data.value(forKey: "id") as? UUID, let imageData = data.value(forKey: "imageData") as? Data, let album_id = data.value(forKey: "selected_album_id") as? UUID {
                photoArray.append(PhotoModel(id: id, imageData: imageData, selected_album_id: album_id))
            }
        }
    }
    
    func saveImageToCoreData(_ imageData: Data, albumID: UUID) {
        let id = UUID()
        if let albumIndex = albumArray.firstIndex(where: { $0.id == albumID }) {
            CoreDataManager.saveData(container: "Vault", entity: "Photo", attributeDict: [
                "imageData": imageData,
                "selected_album_id": albumID,
                "id": id
            ])
            let photo = PhotoModel(id: id, imageData: imageData, selected_album_id: albumID)
            albumArray[albumIndex].images?.append(photo)
            DispatchQueue.main.async {
                self.fetchImages()
                self.collectionView.objects = photoArray
            }
        }
    }
}
