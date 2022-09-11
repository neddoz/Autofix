//
//  ListingDetailViewController+Extension.swift
//  AutoFix
//
//  Created by kayeli dennis on 11/09/2022.
//

import UIKit

extension ListingDetailViewController {

    func setUpUI() {
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5).isActive = true
        
        tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
