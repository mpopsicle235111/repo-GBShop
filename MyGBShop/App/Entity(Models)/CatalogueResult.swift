//
//  CatalogueResult.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 12.07.2022.
//

import Foundation

//MARK: - Catalogue
struct CatalogueResult: Codable {
    let pageNumber: Int
    let items: [ItemResult]
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page_number"
        case items
    }
}

//MARK: - Item
struct ItemResult: Codable {
    let itemId: Int
    let itemName: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case itemId = "item_id"
        case itemName = "item_name"
        case price
    }
}
