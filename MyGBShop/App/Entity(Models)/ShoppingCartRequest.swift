//
//  ShoppingCartRequest.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 25.07.2022.
//

import Foundation

struct ShoppingCartRequest: Codable {
     let itemId: Int
     let quantity: Int

     enum CodingKeys: String, CodingKey {
         case itemId = "itemId"
         case quantity
     }
 }
