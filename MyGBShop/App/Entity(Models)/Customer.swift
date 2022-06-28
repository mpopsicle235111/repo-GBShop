//
//  Customer.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 19.06.2022.
//

import Foundation

// MARK: - CustomersContainer
struct CustomersContainer: Codable {
    let response: CustomersResponse
}

//MARK: - Response
struct CustomersResponse: Codable {
    let count: Int
    let items: [CustomerAPI]
}

/// Friend is our replacement for Item from the example
struct CustomerAPI: Codable, Identifiable {
    let canAccessClosed: Bool?   //Here we make optional something that may
    let domain: String           //be missing, like friend name
    let city: City?            //etc.
    let id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let trackCode: String?
    let isClosed: Bool?
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case domain, city, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
    
}

//MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}

