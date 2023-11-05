//
//  NotesViewController.swift
//  Vault
//
//  Created by Mehmet Kaan on 3.11.2023.
//

import UIKit
import NeonSDK

class NotesVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notesTableView: NotesTableView!
    var searchBar: UITextField!
    
    internal let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Text Here"
        tf.font = Font.custom(size: 16, fontWeight: .Regular)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    internal let descriptiontextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Text Here"
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
        label.text = "Notes"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = Font.custom(size: 25, fontWeight: .Medium)
        return label
    }()
    
    var customView: NoView!
    
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
        fetchFromCoreData()
        view.backgroundColor = .headercolor
        view.addSubview(content)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        
        content.addSubview(saveButton)
        content.addSubview(cancelButton)
        content.addSubview(textField)
        content.addSubview(descriptiontextField)
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
    
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
        
        if noteArray.isEmpty {
            customView = NoView(text: "There is No Notes", description: "You don't have any notes yet.", image: "img_notes")
            content.addSubview(customView)
            customView.snp.makeConstraints { make in
                make.centerX.equalTo(content.snp.centerX)
                make.top.equalTo(content.snp.top).offset(100)
            }
        } else {
            searchBar = UITextField()
            searchBar.placeholder = "Search"
            searchBar.borderStyle = .roundedRect
            searchBar.delegate = self
            content.addSubview(searchBar)
            
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(content.snp.top).offset(30)
                make.left.equalTo(content.snp.left).offset(30)
                make.right.equalTo(content.snp.right).offset(-30)
                make.height.equalTo(50)
            }
            
            notesTableView = NotesTableView()
            content.addSubview(notesTableView)
            notesTableView.layer.cornerRadius = 10
            notesTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            notesTableView.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom).offset(25)
                make.left.right.bottom.equalToSuperview()
            }
        }
        
        configureFunctions()
        
    }
    
    private func configureFunctions() {
        notesTableView.didSelect = { object, indexPath in
            print(indexPath.row)
        }
        
        notesTableView.trailingSwipeActions = [
            SwipeAction(title: "Delete", color: .red, action: { note, indexPath in
                noteArray.remove(at: indexPath.row)
                self.notesTableView.reloadData()
            })
        ]
        
        addButton.addAction {
            if noteArray.isEmpty {
                self.customView.isHidden = true
            } else {
                self.searchBar.isHidden = true
                self.notesTableView.isHidden = true
            }
            self.textField.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(150)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(350)
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
                CoreDataManager.saveData(container: "Vault", entity: "Note", attributeDict: [
                    "title": self.textField.text!,
                ])
            }
        }
    }
}
