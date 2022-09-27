//
//  Theme.swift
//  Message
//
//  Created by Марк Коваль on 10/09/2022.
//

import UIKit

enum Theme: Int {
    case light
    case dark
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        
        switch self {
            
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
