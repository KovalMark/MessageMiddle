//
//  ObjectAnimatable.swift
//  Message
//
//  Created by Марк Коваль on 19/09/2022.
//

import UIKit

protocol ObjectAnimatable {
    func animatable(with object: UIView, duration: Double)
}

extension ObjectAnimatable {
    func animatable(with object: UIView, duration: Double) {
        
        object.alpha = 0
        UIView.animate(withDuration: TimeInterval(duration),
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
            object.alpha = 1
        })
    }
}
