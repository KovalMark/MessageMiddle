//
//  CustomLabel.swift
//  Message
//
//  Created by Марк Коваль on 15/09/2022.
//

import UIKit

//MARK: CustomUIView
final class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setupView
    private func setupView() {
        tintColor = UIColor(named: "textColor")
        textAlignment = .center
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
