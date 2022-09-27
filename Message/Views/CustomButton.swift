//
//  CustomButton.swift
//  Message
//
//  Created by Марк Коваль on 12/09/2022.
//

import UIKit

//MARK: CustomButton
final class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setupView
    private func setupView() {
        backgroundColor = UIColor(named: "textColor")
        tintColor = UIColor(named: "textColor")
        setTitleColor(UIColor(named: "backgroundColor"), for: .normal)
        layer.cornerRadius = 20
        titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        setTitle("Send", for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
