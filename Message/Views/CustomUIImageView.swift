//
//  CustomUIImageView.swift
//  Message
//
//  Created by Марк Коваль on 19/09/2022.
//

import UIKit

//MARK: CustomUIImageView
final class CustomUIImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setUpView
    private func setUpView() {
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
}
