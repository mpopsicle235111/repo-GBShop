//
//  AuthRequestFactory.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 22.06.2022.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {

    func login(userName: String,
                password: String,
                completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)

    func logout(userID: Int,
                 completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)

}
