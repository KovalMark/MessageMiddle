//
//  extension+StartController.swift
//  Message
//
//  Created by Марк Коваль on 12/09/2022.
//

import UIKit

extension StartController {
    
    //MARK: dismissKeyboard
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Keyboard Notifications
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyBoardFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        messageTable.contentOffset = CGPoint(x: 0, y: -keyBoardFrameSize.height)
    }
    
    @objc func keyboardWillHide() {
        messageTable.contentOffset = CGPoint.zero
    }
    
    // MARK: Animate indicator
    func startAnimateIndicator() {
        indicator.startAnimating()
        messageTable.tableFooterView = indicator
        messageTable.tableFooterView?.isHidden = false
    }
    
    func stopAnimateIndicator() {
        messageTable.tableFooterView = nil
        messageTable.tableFooterView?.isHidden = true
    }
}
