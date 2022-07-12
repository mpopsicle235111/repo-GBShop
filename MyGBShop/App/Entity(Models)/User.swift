//
//  User.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 23.06.2022.
//

import Foundation

struct User: Codable {
     let id: Int?
     let login: String?
     let firstName: String?
     let lastName: String?
     let password: String?
     let email: String?
     let gender: String?
     let creditCardNumber: String?
     let tagLine: String?

     enum CodingKeys: String, CodingKey {
         case id = "id_user"
         case login = "user_login"
         case firstName = "user_name"
         case lastName = "user_lastname"
         case password
         case email
         case gender
         case creditCardNumber = "credit_card_number"
         case tagLine
     }
    
        init(id: Int? = nil,
             login: String? = nil,
             firstName: String? = nil,
             lastName: String? = nil,
             password: String? = nil,
             email: String? = nil,
             gender: String? = nil,
             creditCardNumber: String? = nil,
             tagLine: String? = nil) {
            self.id = id
            self.login = login
            self.firstName = firstName
            self.lastName = lastName
            self.password = password
            self.email = email
            self.gender = gender
            self.creditCardNumber = creditCardNumber
            self.tagLine = tagLine
        }
    
 }
