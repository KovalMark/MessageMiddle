//
//  extension+tableViewHeader.swift
//  Message
//
//  Created by Марк Коваль on 14/09/2022.
//

import UIKit

// MARK: TableViewHeader
extension StartController {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))

        headerView.backgroundColor = UIColor(named: "backgroundColor")
        headerView.addSubview(boxMessage)
        boxMessage.addSubview(messageTextField)
        boxMessage.addSubview(messageButton)
        headerView.transform = messageTable.transform
        
        NSLayoutConstraint.activate([
            boxMessage.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 0),
            boxMessage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            boxMessage.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: 0),
            boxMessage.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            messageTextField.leftAnchor.constraint(equalTo: boxMessage.leftAnchor, constant: 40),
            messageTextField.topAnchor.constraint(equalTo: boxMessage.topAnchor),
            messageTextField.rightAnchor.constraint(equalTo: messageButton.leftAnchor, constant: -10),
            messageTextField.bottomAnchor.constraint(equalTo: boxMessage.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            messageButton.leftAnchor.constraint(equalTo: messageTextField.rightAnchor, constant: 10),
            messageButton.topAnchor.constraint(equalTo: boxMessage.topAnchor),
            messageButton.rightAnchor.constraint(equalTo: boxMessage.rightAnchor, constant: -40),
            messageButton.bottomAnchor.constraint(equalTo: boxMessage.bottomAnchor),
            messageButton.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        return headerView
    }
}
