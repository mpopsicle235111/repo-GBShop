//
//  DefaultResponse.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 19.07.2022.
//
import Foundation

  struct DefaultResult: Codable {
      var result: Int
      var successMessage: String?
      var errorMessage: String?
  }

