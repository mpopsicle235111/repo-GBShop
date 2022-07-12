//
//  CatalogueRequestFactory.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 12.07.2022.
//

import Foundation
import Alamofire

protocol CatalogueRequestFactory {
    func getCatalogue(pageNumber: Int, categoryNumber: Int, completionHandler: @escaping (AFDataResponse<[ItemResult]>) -> Void)
}
