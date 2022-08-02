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
    let itemId: Int?
    let itemName: String?
    let price: Int?
    let shortDescription: String?
    let picUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case itemId = "itemId"
        case itemName = "itemName"
        case price
        case shortDescription
        case picUrl
    }
}
