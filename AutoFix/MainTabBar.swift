//
//  MainTabBar.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import UIKit

class MainTabBar: UITabBarController {

    init(vcs: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = vcs
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
