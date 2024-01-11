//
//  MainTabBarViewController.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 11.01.2024.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let viewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: viewModel)
        
        homeViewController.title = "Home"
        let vc1 = UINavigationController(rootViewController: homeViewController)
        let vc2 = UINavigationController(rootViewController: TransactionsViewController())
        let vc3 = UINavigationController(rootViewController: SettingsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "arrow.left.arrow.right")
        vc3.tabBarItem.image = UIImage(systemName: "gearshape.fill")
        
        vc2.title = "Transactions"
        vc3.title = "Settings"
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
}
