//
//  ShoppingCartResult.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 25.07.2022.
//

import Foundation

struct ShoppingCartResult: Codable {
     let totalAmount: Int
     let contents: [ShoppingCartContent]
     let itemsCount: Int
 }

 // MARK: - Content
 struct ShoppingCartContent: Codable {
     let itemName: String
     let quantity, price, itemId: Int

     enum CodingKeys: String, CodingKey {
         case itemName = "itemName"
         case quantity, price
         case itemId = "itemId"
     }
 }
