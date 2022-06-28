//
//  ResponseCodable.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 23.06.2022.
//

import Foundation
import Alamofire

class CustomDecodableSerializer<T: Decodable>: DataResponseSerializerProtocol {

    private let errorParser: AbstractErrorParser

    init(errrorParser: AbstractErrorParser) {
         self.errorParser = errrorParser
    }

    func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> T {
        if let error = errorParser.parse(response: response, data: data, error: error) {
             throw error
        }
        do {
            let data = try DataResponseSerializer().serialize(request: request, response: response, data: data, error: error)
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch {
            let customError = errorParser.parse(error)
            throw customError
        }
    }
}

extension DataRequest {
    @discardableResult
    func responseCodable<T: Decodable>(errorParser: AbstractErrorParser, queue: DispatchQueue = .main, completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
         let responseSerializer = CustomDecodableSerializer<T>(errrorParser: errorParser)

         return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
