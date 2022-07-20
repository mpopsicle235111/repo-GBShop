//
//  FeedbackResult.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 21.07.2022.
//

import Foundation

struct FeedbackResult: Codable {
     let userId: Int?
     let feedbackText: String?
     let productIdNumber: Int?

     enum CodingKeys: String, CodingKey {
         case feedbackText = "text"
         case userId = "userId"
         case productIdNumber = "itemId"

     }
 }
