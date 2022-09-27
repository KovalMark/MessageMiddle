//
//  InfoController.swift
//  Message
//
//  Created by Марк Коваль on 19/09/2022.
//

import UIKit

// MARK: InfoController
final class InfoController: UIViewController, ObjectAnimatable {    
    
    let startController = StartController()
    let messageLabel = CustomLabel()
    weak var delegate: StartController?
    private let avatarImage = CustomUIImageView(frame: .zero)
    private let deleteButton = CustomButton()
    private let messageDate = CustomLabel()
    private let date = Date()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
        animationObject()
    }
    
    override func viewDidLayoutSubviews() {
        avatarImage.createRoundPicture(imageName: avatarImage)
    }
    
    // MARK: Setting Views
    private func settingViews() {
        avatarImage.loadImage(with: Constants.instance.urlImage)
        messageDate.text = date.toJustTime
        deleteButton.setTitle("Удалить сообщение", for: .normal)
        deleteButton.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
    }
    
    @objc private func tapDeleteButton() {
        delegate?.deleteItemFromData()
        navigationController?.popViewController(animated: true)
    }
    
    private func animationObject() {
        animatable(with: avatarImage, duration: 1)
        animatable(with: messageLabel, duration: 1)
        animatable(with: messageDate, duration: 1)
        animatable(with: deleteButton, duration: 1)
    }
    
    // MARK: Setup Views
    private func setUpView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(avatarImage)
        view.addSubview(messageLabel)
        view.addSubview(messageDate)
        view.addSubview(deleteButton)
        settingViews()
    }
}

// MARK: setUpConstraints
extension InfoController {
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImage.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            messageLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(equalTo: messageDate.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            messageDate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            messageDate.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            deleteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            deleteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
