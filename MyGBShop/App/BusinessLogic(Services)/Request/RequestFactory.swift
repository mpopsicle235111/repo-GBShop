//
//  RequestFactory.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 23.06.2022.
//

import Foundation
import Alamofire

class RequestFactory {

    func makeErrorParser() -> AbstractErrorParser {
         return ErrorParser()
    }

    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()

    let sessionQueue = DispatchQueue.global(qos: .utility)

    // MARK: - Auth
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser,
                    sessinManager: commonSession,
                    queue: sessionQueue)
     }

    // MARK: - Regist
    func makeRegistRequestFactory() -> RegistrationRequestFactory {
        let errorParser = makeErrorParser()
        return Registration(errorParser: errorParser, sessinManager: commonSession, queue: sessionQueue)
    }

    // MARK: - СhangeUserData
    func makeСhangeUserDataFactory() -> СhangeUserDataRequestFactory {
         let errorParser = makeErrorParser()
         return СhangeUserData(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
