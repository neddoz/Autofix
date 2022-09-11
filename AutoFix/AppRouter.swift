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
        vc.tabBarItem.image = UIImage(systemName: "house")
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
    
    fileprivate lazy var homeNav: UINavigationController = {
        let nav = UINavigationController(rootViewController: homeViewController)
        nav.navigationBar.prefersLargeTitles = false
        nav.navigationItem.largeTitleDisplayMode = .never
        return nav
    }()

    func rootController() -> UIViewController {
        let vcs:[UINavigationController] = [homeViewController, favouritesViewController, accountViewController].map {
            if $0 is HomeViewController {
                return homeNav
            } else {
                return UINavigationController(rootViewController: $0)
            }
        }
        let mainTabBar = MainTabBar(vcs: vcs)
        return mainTabBar
    }
    
    func presentImageDetailViewController(for item: String) {
        let viewModel = ListingDetailViewModel(carId: item)
        let vc = ListingDetailViewController(viewModel: viewModel)
        homeNav.navigationBar.prefersLargeTitles = false
        homeViewController.navigationController?.pushViewController(vc, animated: false)
    }

    init() {
        homeNav.isNavigationBarHidden = false
        homeNav.navigationItem.largeTitleDisplayMode = .never
        homeNav.navigationBar.prefersLargeTitles = false
        
    }
}
