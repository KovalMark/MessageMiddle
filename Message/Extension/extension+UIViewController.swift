//
//  extension+UIViewController.swift
//  Message
//
//  Created by Марк Коваль on 10/09/2022.
//

import UIKit

extension UIViewController {
    
    //MARK: Navigation Bar
    func createCustomNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
        self.navigationItem.title = ""
    }
    
    //MARK: Error Alert
    func showAlert(title: String, message: String) {
        
        let alertVC = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}
