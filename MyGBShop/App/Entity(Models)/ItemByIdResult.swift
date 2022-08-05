//
//  ItemByIdResult.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 12.07.2022.
//

import Foundation

//MARK: - ItemById
struct ItemByIdResult: Codable {
    let result: Int?
    let itemName: String?
    let price: Int?
    let description: String?
    let itemId: Int?
    let picUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case itemName = "item_name"
        case price
        case description
        case itemId = "id_product"
        case picUrl
    }
}
