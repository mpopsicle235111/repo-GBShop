//
//  TabBarViewController.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 27.07.2022.
//

import UIKit

final class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        //let mainScreenVC = MainScreenViewController()
        let catalogueTableViewController = CatalogueTableViewController()

        let tabBarItemMainScreen = UITabBarItem(title: "Shopping Area",
                                                image: UIImage(systemName: "cart"),
                                                selectedImage: UIImage(systemName: "cart.fill"))

        //mainScreenVC.tabBarItem = tabBarItemMainScreen
        catalogueTableViewController.tabBarItem = tabBarItemMainScreen
        
        tabBar.isTranslucent = true


        let GetUserDataVC = GetUserDataViewController()

        let tabBarItemGetUserData = UITabBarItem(title: "Preferences",
                                                 image: UIImage(systemName: "person.crop.circle.badge.checkmark"),
                                                 selectedImage: UIImage(systemName: "person.crop.circle.fill.badge.checkmark"))

        GetUserDataVC.tabBarItem = tabBarItemGetUserData
        self.viewControllers = [catalogueTableViewController, GetUserDataVC]

    }
}
