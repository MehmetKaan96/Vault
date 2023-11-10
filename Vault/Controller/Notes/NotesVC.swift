//
//  NotesViewController.swift
//  Vault
//
//  Created by Mehmet Kaan on 3.11.2023.
//

import UIKit
import NeonSDK

class NotesVC: UIViewController {
    var notesTableView =  NotesTableView()
    var searchBar = UISearchBar()
    let saveButton = UIButton()
    let cancelButton = UIButton()
    let addButton = UIButton()
    let backButton = UIButton()
    let textView =  NeonTextView()
    let descriptionTextView = NeonTextView()
    let titleLabel = UILabel()
    let customView = NoView(text: "There is No Notes", description: "You don't have any notes yet.", image: "img_notes")
    let content = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
  
    func createUI() {
        fetchFromCoreData()
        view.backgroundColor = .headercolor
    
        content.backgroundColor = .white
        content.layer.cornerRadius = 15
        content.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(content)
        content.snp.makeConstraints { make in
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
        
        titleLabel.text = "Notes"
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
        
        if noteArray.isEmpty {
            content.addSubview(customView)
            customView.snp.makeConstraints { make in
                make.centerX.equalTo(content.snp.centerX)
                make.top.equalTo(content.snp.top).offset(100)
            }
        } else {
            searchBar.placeholder = "Search"
            searchBar.setImage(UIImage(), for: .search, state: .normal)
            searchBar.searchBarStyle = .minimal
            
            if let textfield = self.searchBar.value(forKey: "searchField") as? UITextField {
                
                textfield.backgroundColor = .white
            }
            searchBar.delegate = self
            content.addSubview(searchBar)
            
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(content.snp.top).offset(30)
                make.left.equalTo(content.snp.left).offset(30)
                make.right.equalTo(content.snp.right).offset(-30)
                make.height.equalTo(50)
            }
            content.addSubview(notesTableView)
            notesTableView.layer.cornerRadius = 10
            notesTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            notesTableView.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
            
            notesTableView.didSelect = { object, indexPath in
                print(indexPath.row)
            }
            
            notesTableView.trailingSwipeActions = [
                SwipeAction(title: "Delete", color: .red, action: { [self] note, indexPath in
                    CoreDataManager.deleteData(container: "Vault", entity: "Note", searchKey: "title", searchValue: "\(noteArray[indexPath.row].title)")
                    noteArray.remove(at: indexPath.row)
                    self.notesTableView.objects = noteArray
                    
                    if noteArray.isEmpty {
                        self.notesTableView.isHidden = true
                        self.searchBar.isHidden = true
                        self.content.addSubview(self.customView)
                        customView.snp.remakeConstraints { make in
                            make.centerX.equalTo(content.snp.centerX)
                            make.top.equalTo(content.snp.top).offset(100)

                        }
                    }
                    
                })
            ]
            
        }
        
        configureFunctions()
        
    }
        
    func configureFunctions() {
        backButton.addAction {
            self.dismiss(animated: true)
        }
        
        addButton.addAction { [self] in
            if noteArray.isEmpty {
                self.customView.isHidden = true
            } else {
                self.searchBar.isHidden = true
                self.notesTableView.isHidden = true
            }
            
            textView.placeholder = "Enter your text"
            textView.placeholderColor = .gray
            textView.textAlignment = .left
            textView.layer.cornerRadius = 10
            textView.layer.borderWidth = 0.5
            content.addSubview(textView)
            self.textView.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(150)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(75)
            }
            
            descriptionTextView.placeholder = "Enter your text"
            descriptionTextView.placeholderColor = .gray
            descriptionTextView.textAlignment = .left
            descriptionTextView.layer.cornerRadius = 10
            descriptionTextView.layer.borderWidth = 0.5
            content.addSubview(descriptionTextView)
            self.descriptionTextView.snp.makeConstraints { make in
                make.top.equalTo(self.textView.snp.bottom).offset(20)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(350)
            }
            
            saveButton.setTitle("Save", for: .normal)
            saveButton.backgroundColor = .systemBlue
            saveButton.layer.cornerRadius = 10
            saveButton.setTitleColor(.white, for: .normal)
            content.addSubview(saveButton)
            self.saveButton.snp.makeConstraints { make in
                make.top.equalTo(self.descriptionTextView.snp.bottom).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(51)
                make.width.equalTo(160)
            }
            
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.backgroundColor = .white
            cancelButton.layer.cornerRadius = 10
            cancelButton.setTitleColor(.black, for: .normal)
            content.addSubview(cancelButton)
            self.cancelButton.snp.makeConstraints { make in
                make.top.equalTo(self.descriptionTextView.snp.bottom).offset(20)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.height.equalTo(51)
                make.width.equalTo(174)
                make.right.equalTo(self.saveButton.snp.left).offset(-20)
            }
            
            self.saveButton.addAction {
                CoreDataManager.saveData(container: "Vault", entity: "Note", attributeDict: [
                    "title": self.textView.text!,
                    "desc" : self.descriptionTextView.text!
                ])
                self.dismiss(animated: true)
            }
            
            self.cancelButton.addAction {
                self.dismiss(animated: true)
            }
        }
    }
}
