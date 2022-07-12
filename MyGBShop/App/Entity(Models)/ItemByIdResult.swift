//
//  ItemByIdResult.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 12.07.2022.
//

import Foundation

//MARK: - ItemById
struct ItemByIdResult: Codable {
    let result: Int
    let itemName: String
    let itemPrice: Int
    let itemDescription: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case itemName = "item_name"
        case itemPrice = "item_price"
        case itemDescription = "item_description"
    }
}
