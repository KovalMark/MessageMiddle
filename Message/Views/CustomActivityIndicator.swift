//
//  CustomActivityIndicator.swift
//  Message
//
//  Created by Марк Коваль on 15/09/2022.
//

import UIKit

//MARK: CustomActivityIndicator
final class CustomActivityIndicator: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style = .large
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
