//
//  ChangeUserDataRequestFactory.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 23.06.2022.
//

import Foundation
import Alamofire

protocol СhangeUserDataRequestFactory {
    func changeUserData(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
}

