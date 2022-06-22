//
//  RequestRouter.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 23.06.2022.
//

import Foundation
import Alamofire

enum RequestRouterEncoding {
     case url, json
}

protocol RequestRouter: URLRequestConvertible {
    var baseURL: URL { get }
    var metod: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var fullURL: URL { get }
    var encoding: RequestRouterEncoding { get }
}

extension RequestRouter {
    var fullURL: URL {
        return baseURL.appendingPathComponent(path)
    }

    var encoding: RequestRouterEncoding {
        return .url
    }

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = metod.rawValue

        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
