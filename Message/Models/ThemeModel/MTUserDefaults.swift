//
//  MTUserDefaults.swift
//  Message
//
//  Created by Марк Коваль on 10/09/2022.
//

import UIKit

struct MTUserDefaults {
    
    static var shared = MTUserDefaults()
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "selectedTheme")) ?? .light
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
        }
    }
}
