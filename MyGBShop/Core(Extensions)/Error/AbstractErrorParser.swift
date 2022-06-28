//
//  AbstractErrorParser.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 23.06.2022.
//

import Foundation
protocol AbstractErrorParser {

     func parse(_ result: Error) -> Error

     func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
