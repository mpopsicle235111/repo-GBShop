//
//  Session.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 19.06.2022.
//

import Foundation

/// This singletone stores data about the current session
final class Session: ObservableObject {
    private init() {}
    
    static let shared = Session()
    
    @Published var token = ""// Stores user token in VK
    @Published var userId = "" // Stores user identifier in VK
    
}

