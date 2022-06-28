//
//  ErrorParser.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 23.06.2022.
//

import Foundation

class ErrorParser: AbstractErrorParser {
     func parse(_ result: Error) -> Error {
         return result
     }

     func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
         return error
     }


}
