//
//  Auth.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 22.06.2022.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!

    init (
        errorParser: AbstractErrorParser,
        sessinManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
             self.errorParser = errorParser
             self.sessionManager = sessinManager
             self.queue = queue
        }
}

extension Auth: AuthRequestFactory {

     func login(userName: String,
                password: String,
                completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
         let requestModel = Login(baseURL: baseUrl,
                                  login: userName,
                                  password: password)
         self.request(request: requestModel,
                      completionHandler: completionHandler)
     }
 }

extension Auth {

    func logout(userID: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseURL: baseUrl, userID: userID)
        self.request(request: requestModel,
                      completionHandler: completionHandler)
    }
}

// MARK: Login
 extension Auth {

     struct Login: RequestRouter {
         var baseURL: URL
         var metod: HTTPMethod = .get
         var path: String = "login.json"

         let login: String
         let password: String
         var parameters: Parameters? {
             return [
                 "username": login ,
                 "password": password
             ]
         }
     }
 }

 // MARK: Logout
 extension Auth {

     struct Logout: RequestRouter {
         var baseURL: URL
         var metod: HTTPMethod = .get
         var path: String = "logout.json"

         let userID: Int
         var parameters: Parameters? {
             return [
                 "id_user": userID
             ]
         }
     }
 }
