//
//  ReuseIdentifying.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import UIKit

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifying {}
extension UICollectionViewCell: ReuseIdentifying {}
