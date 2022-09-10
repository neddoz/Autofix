//
//  AppRouter.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//
import UIKit

final class AppRouter {

    static let shared = AppRouter()
    
    lazy var homeViewController: HomeViewController = {
        let vc = HomeViewController()
        vc.tabBarItem.image = UIImage(systemName: "person")
        vc.tabBarItem.title = ""
        return vc
    }()
    
    lazy var favouritesViewController: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.tabBarItem.image = .init(named: "favorite-favorite_symbol")
        vc.tabBarItem.title = ""
        return vc
    }()
    
    lazy var accountViewController: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.tabBarItem.image = UIImage(systemName: "person")
        vc.tabBarItem.title = ""
        return vc
    }()
    
    fileprivate lazy var root: UINavigationController = {
        return UINavigationController(rootViewController: homeViewController)
    }()

    func rootController() -> UIViewController {
        let mainTabBar = MainTabBar(vcs: [homeViewController, favouritesViewController, accountViewController])
        return mainTabBar
    }

    init() {
        root.isNavigationBarHidden = false
        root.navigationBar.prefersLargeTitles = true
    }
}
