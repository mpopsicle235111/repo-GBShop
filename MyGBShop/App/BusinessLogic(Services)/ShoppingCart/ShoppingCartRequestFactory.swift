//
//  ShoppingCartRequestFactory.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 25.07.2022.
//

import Foundation
import Alamofire

 protocol ShoppingCartRequestFactory {
     func getShoppingCart(user: User, completionHandler: @escaping (AFDataResponse<ShoppingCartResult>) -> Void)
     func payForShoppingCart(user: User, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
     func addToShoppingCart(shoppingCart: ShoppingCartRequest, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
     func deleteFromShoppingCart(shoppingCart: ShoppingCartRequest, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)

     }
