//
//  Catalogue.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 10.07.2022.
//

import Foundation
import Alamofire

class Catalogue: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    //let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    let baseUrl = URL(string: "https://thawing-meadow-23707.herokuapp.com/")!
    
    init (
        errorParser: AbstractErrorParser,
        sessinManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessinManager
            self.queue = queue
            
        }
}

extension Catalogue: CatalogueRequestFactory {
    
    func getCatalogue(pageNumber: Int, categoryNumber: Int, completionHandler: @escaping (AFDataResponse<CatalogueResult>) -> Void) {
        let requestModel = GetCatalogue(baseURL: baseUrl, pageNumber: pageNumber, categoryNumber: categoryNumber)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Catalogue {
    struct GetCatalogue: RequestRouter {
        var baseURL: URL
        var method: HTTPMethod = .post
        var path: String = "catalogueData.json"
        let pageNumber: Int
        let categoryNumber: Int
        
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "category_number": categoryNumber
            ]
        }
    }
}

