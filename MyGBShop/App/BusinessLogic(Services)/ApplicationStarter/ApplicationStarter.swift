//
//  ApplicationStarter.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 26.07.2022.
//

import UIKit

final class ApplicationStarter {

    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func startApplication() {
        let rootVC = AuthViewController()
        rootVC.navigationItem.title = "MyGBShop v.11.0"

        let navVC = self.configuredNavigationController
        navVC.viewControllers = [rootVC]

        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }

    private lazy var configuredNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = .lightGray
        navVC.navigationBar.isTranslucent = true
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        return navVC
    }()

}
