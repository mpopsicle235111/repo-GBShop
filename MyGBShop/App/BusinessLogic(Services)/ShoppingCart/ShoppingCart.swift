//
//  ShoppingCart.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 25.07.2022.
//

import Foundation
import Alamofire

 class ShoppingCart: AbstractRequestFactory {
     let errorParser: AbstractErrorParser
     let sessionManager: Session
     let queue: DispatchQueue
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

 extension ShoppingCart: ShoppingCartRequestFactory {
     func getShoppingCart(user: User, completionHandler: @escaping (AFDataResponse<ShoppingCartResult>) -> Void) {
         let requestModel = GetShoppingCart(baseURL: baseUrl, userId: user.id ?? 0)
         self.request(request: requestModel,
                      completionHandler: completionHandler)
     }

     func payForShoppingCart(user: User, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
         let requestModel = PayForShoppingCart(baseURL: baseUrl, userId: user.id ?? 0)
         self.request(request: requestModel,
                      completionHandler: completionHandler)
     }

     func addToShoppingCart(shoppingCart: ShoppingCartRequest, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
         let requestModel = AddToShoppingCart(baseURL: baseUrl, shoppingCart: shoppingCart)
         self.request(request: requestModel,
                      completionHandler: completionHandler)
     }

     func deleteFromShoppingCart(shoppingCart: ShoppingCartRequest, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
         let requestModel = DeleteFromShoppingCart(baseURL: baseUrl, shoppingCart: shoppingCart)
         self.request(request: requestModel,
                      completionHandler: completionHandler)
     }


 }

 extension ShoppingCart {
     struct GetShoppingCart: RequestRouter {
         let baseURL: URL
         let method: HTTPMethod = .post
         let path: String = "getShoppingCart.json"
         let userId: Int

         var parameters: Parameters? {
             return [
                 "userId": userId
             ]
         }
     }
 }

 extension ShoppingCart {
     struct PayForShoppingCart: RequestRouter {
         let baseURL: URL
         let method: HTTPMethod = .post
         let path: String = "payForShoppingCart.json"
         let userId: Int

         var parameters: Parameters? {
             return [
                 "userId": userId
             ]
         }
     }
 }

 extension ShoppingCart {
     struct AddToShoppingCart: RequestRouter {
         let baseURL: URL
         let method: HTTPMethod = .post
         let path: String = "addToShoppingCart.json"
         let shoppingCart: ShoppingCartRequest

         var parameters: Parameters? {
             return [
                 "itemId" : shoppingCart.itemId,
                 "quantity" : shoppingCart.quantity
             ]
         }
     }
 }

 extension ShoppingCart {
     struct DeleteFromShoppingCart: RequestRouter {
         let baseURL: URL
         let method: HTTPMethod = .post
         let path: String = "deleteFromShoppingCart.json"
         let shoppingCart: ShoppingCartRequest

         var parameters: Parameters? {
             return [
                 "itemId" : shoppingCart.itemId
             ]
         }
     }
 }
