//
//  CustomTextField.swift
//  Message
//
//  Created by Марк Коваль on 12/09/2022.
//

import UIKit

//MARK: TextFieldView
final class CustomTextField: UITextField, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setupView
    private func setupView() {
        backgroundColor = UIColor(named: "backgroundColor")
        textColor = UIColor(named: "textColor")
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 10
        borderStyle = .roundedRect
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        leftViewMode = .always
        returnKeyType = .done
        keyboardType = .default
        placeholder = "Сообщение"
        translatesAutoresizingMaskIntoConstraints = false
    }
}
