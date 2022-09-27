//
//  extension+Date.swift
//  Message
//
//  Created by Марк Коваль on 27/09/2022.
//

import UIKit

extension Date {
    
    var toJustTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}
