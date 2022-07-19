//
//  ItemById.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 12.07.2022.
//

import Foundation
import Alamofire

class ItemById: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    //let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    let baseUrl = URL(string: "https://boiling-wildwood-30728.herokuapp.com/")!
    
    init (
        errorParser: AbstractErrorParser,
        sessinManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessinManager
        self.queue = queue
    }
}

extension ItemById: ItemByIdRequestFactory {
    
    
    func getItem(productIdNumber: Int, completionHandler: @escaping (AFDataResponse<ItemByIdResult>) -> Void) {
        let requestModel = ItemById(baseURL: baseUrl, productIdNumber: productIdNumber)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension ItemById {
    struct ItemById: RequestRouter {
        var baseURL: URL
        //var method: HTTPMethod = .get
        var method: HTTPMethod = .post
        var path: String = "getItemById.json"
        let productIdNumber: Int
        
        var parameters: Parameters? {
            return [
                "productId" : productIdNumber
            ]
        }
    }
}
