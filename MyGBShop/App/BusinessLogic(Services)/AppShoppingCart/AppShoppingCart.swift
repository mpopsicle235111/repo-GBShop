//
//  AppShoppingCart.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 18.08.2022.
//

import Foundation

class AppShoppingCart {
     static let shared = AppShoppingCart()
     init(){}

     var items: [AppShoppingCartItem] = []
 }

 struct AppShoppingCartItem {
     let productIdNumber: Int?
     let itemName: String?
     let price: Int?
     let picUrl: String?
 }
