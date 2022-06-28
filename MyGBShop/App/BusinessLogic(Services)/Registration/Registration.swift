//
//  Registration.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 22.06.2022.
//

import Foundation
import Alamofire

class Registration: AbstractRequestFactory {

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

extension Registration: RegistrationRequestFactory {

    func register(user: User,
                   completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void) {
        let requestModel = Register(baseURL: baseUrl, user: user)
        self.request(request: requestModel,
                      completionHandler: completionHandler)

    }

}

extension Registration {
    struct Register: RequestRouter {
        let baseURL: URL
        let metod: HTTPMethod = .get
        let path: String = "registerUser.json"

        let user: User
        var parameters: Parameters? {
            return [
                "id_user": user.id,
                "username": user.login ,
                "password": user.password ?? "",
                "email": user.email ?? "",
                "gender": user.gender ?? "",
                "credit_card": user.creditCardNumber ?? "",
                "bio": user.tagLine ?? ""
            ]
        }
    }
}
