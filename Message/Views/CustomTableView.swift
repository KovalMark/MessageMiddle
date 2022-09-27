//
//  CustomTableView.swift
//  Message
//
//  Created by Марк Коваль on 15/09/2022.
//

import UIKit

//MARK: CustomTableView
final class CustomTableView: UITableView {
    
    init(frame: CGRect) {
        super.init(frame: .zero, style: .grouped)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setupView
    private func setupView() {
        transform = CGAffineTransform(scaleX: 1, y: -1)
        backgroundColor = UIColor(named: "backgroundColor")
        separatorColor = UIColor(named: "backgroundColor")
        translatesAutoresizingMaskIntoConstraints = false
    }
}
