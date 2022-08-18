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
        
        //Added for testing
        view.accessibilityIdentifier = "tabBarViewController"

        //let mainScreenVC = MainScreenViewController()
        let catalogueTableViewController = CatalogueTableViewController()

        let tabBarItemMainScreen = UITabBarItem(title: "Shopping Area",
                                                image: UIImage(systemName: "list.bullet.rectangle"),
                                                selectedImage: UIImage(systemName: "list.bullet.rectangle.fill"))

        //mainScreenVC.tabBarItem = tabBarItemMainScreen
        catalogueTableViewController.tabBarItem = tabBarItemMainScreen
        
        tabBar.isTranslucent = true


        let getUserDataVC = GetUserDataViewController()

        let tabBarItemGetUserData = UITabBarItem(title: "Preferences",
                                                 image: UIImage(systemName: "person.crop.circle.badge.checkmark"),
                                                 selectedImage: UIImage(systemName: "person.crop.circle.fill.badge.checkmark"))

        getUserDataVC.tabBarItem = tabBarItemGetUserData
        //self.viewControllers = [catalogueTableViewController, GetUserDataVC]
        
        let shoppingCartViewController = ShoppingCartTableViewController()

        let shoppingCartTabBarItem = UITabBarItem(title: "Cart",
                                                       image: UIImage(systemName: "cart"),
                                                       selectedImage: UIImage(systemName: "cart.fill"))

        shoppingCartViewController.tabBarItem = shoppingCartTabBarItem

        self.viewControllers = [catalogueTableViewController, shoppingCartViewController, getUserDataVC]

    }
}
