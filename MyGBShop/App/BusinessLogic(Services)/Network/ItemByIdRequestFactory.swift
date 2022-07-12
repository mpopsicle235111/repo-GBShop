//
//  ItemByIdRequestFactory.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 12.07.2022.
//

import Foundation
import Alamofire

protocol ItemByIdRequestFactory {
    func getItem(productIdNumber: Int, completionHandler: @escaping (AFDataResponse<ItemByIdResult>) -> Void)
}
