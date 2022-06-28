//
//  RegistrationRequestFactory.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 23.06.2022.
//

import Foundation
import Alamofire

protocol RegistrationRequestFactory {

    func register(user: User, completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void)
}

