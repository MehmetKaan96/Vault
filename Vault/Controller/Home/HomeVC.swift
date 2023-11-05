//
//  HomeVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

//MARK: - Buton aksiyonlarını tamamla

import UIKit
import NeonSDK

class HomeVC: UIViewController {

    let headerTitle = HomeDeclarations.headerTitle
    let settingsButton = HomeDeclarations.settingsButton
    let homeView = HomeDeclarations.homeView
    let infoView = HomeDeclarations.infoView
    let imageView = HomeDeclarations.imageView
    let albumLabel = HomeDeclarations.albumLabel
    let notesLabel = HomeDeclarations.notesLabel
    let notesButton = UIButton()
    let albumButton = UIButton()
    let browserButton = CustomButton(text: "Private Browser", image1: UIImage(named: "img_privateBrowser"), image2: UIImage(named: "btn_arrow_right"))
    let passwordButton = CustomButton(text: "Password", image1: UIImage(named: "img_password_1"), image2: UIImage(named: "btn_arrow_right"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createUI()
    }
    
    func createUI() {
        view.backgroundColor = UIColor.headercolor
        
        view.addSubview(headerTitle)
        view.addSubview(settingsButton)
        view.addSubview(homeView)
        homeView.addSubview(infoView)
        homeView.addSubview(notesLabel)
        homeView.addSubview(albumLabel)
        infoView.addSubview(imageView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        headerTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(23)
            make.centerX.equalTo(view.snp.centerX)
        }

        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(23)
            make.left.equalTo(headerTitle.snp.right).offset(118)
            make.right.equalTo(view.snp.right).offset(-27)
        }
        
        homeView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(headerTitle.snp.bottom).offset(30)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.right.left.equalToSuperview().inset(27)
            make.height.equalTo(homeView.snp.height).multipliedBy(0.2)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(infoView.snp.centerY)
            make.right.equalTo(infoView.snp.right)
            make.height.equalTo(110).multipliedBy(0.3)
        }
        
        let headerStack = NeonVStack(width: 150, block: { vStack in
                                                          
            let label = UILabel()
            label.text = "Encrypted Safe Vault"
            label.font = Font.custom(size: 14, fontWeight: .Medium)
            vStack.addArrangedSubview(label)
            label.snp.makeConstraints { make in
                make.height.equalTo(21)
            }
            
            let desclabel = UILabel()
            desclabel.text = "Tap on one of the following categories according to the type of item you want to keep and start saving."
            desclabel.font = Font.custom(size: 11, fontWeight: .Regular)
            desclabel.numberOfLines = 0
            vStack.addArrangedSubview(desclabel)
            desclabel.snp.makeConstraints { make in
                make.height.equalTo(82)
            }

        })
        infoView.addSubview(headerStack)
        headerStack.snp.makeConstraints { make in
            make.centerY.equalTo(infoView.snp.centerY).offset(10)
            make.left.equalTo(infoView.snp.left).offset(20)
        }
        
        let buttonHStack = NeonHStack(height: 100) { hstack in
            albumButton.setImage(UIImage(named: "btn_albums"), for: .normal)
            albumButton.backgroundColor = .white
            albumButton.layer.cornerRadius = 50
            hstack.addArrangedSubview(albumButton)
            albumButton.snp.makeConstraints { make in
                make.width.equalTo(94)
            }
            
            notesButton.setImage(UIImage(named: "btn_notes"), for: .normal)
            notesButton.backgroundColor = .white
            notesButton.layer.cornerRadius = 50
            hstack.addArrangedSubview(notesButton)
            notesButton.snp.makeConstraints { make in
                make.width.equalTo(94)
            }
        }
        
        homeView.addSubview(buttonHStack)
        buttonHStack.spacing = 39
        buttonHStack.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom).offset(63)
            make.centerX.equalTo(homeView.snp.centerX)
        }
        
        albumLabel.snp.makeConstraints { make in
            make.top.equalTo(albumButton.snp.bottom).offset(15)
            make.left.equalTo(homeView.snp.left).offset(105)
        }
        
        notesLabel.snp.makeConstraints { make in
            make.top.equalTo(notesButton.snp.bottom).offset(15)
            make.left.equalTo(albumLabel.snp.right).offset(80)
        }
        
        let buttonVStack = NeonVStack(width: 340) { vstack in
            browserButton.backgroundColor = .white
            vstack.addArrangedSubview(browserButton)
            browserButton.snp.makeConstraints { make in
                make.height.equalTo(80)
            }
            
            passwordButton.backgroundColor = .white
            vstack.addArrangedSubview(passwordButton)
            passwordButton.snp.makeConstraints { make in
                make.height.equalTo(80)
            }
        }
        
        homeView.addSubview(buttonVStack)
        buttonVStack.spacing = 15
        buttonVStack.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(buttonHStack.snp.bottom).offset(66)
            make.centerX.equalTo(homeView.snp.centerX)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).inset(60)
        }
        
        settingsButton.addAction {
            let vc = SettingsVC()
            vc.isHeroEnabled = true
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
        albumButton.addAction {
            let vc = AlbumsVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(destinationVC: vc, slideDirection: .right)
        }
        
        notesButton.addAction {
            let vc = NotesVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(destinationVC: vc, slideDirection: .right)
        }
        
        passwordButton.addAction {
            let vc = PasswordVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(destinationVC: vc, slideDirection: .right)
        }
    }
}

#Preview() {
    HomeVC()
}
