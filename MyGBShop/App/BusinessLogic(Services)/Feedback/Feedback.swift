//
//  Feedback.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 21.07.2022.
//

import Foundation
import Alamofire

 class Feedback: AbstractRequestFactory {
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

 extension Feedback: FeedbackRequestFactory {

     func getFeedback(productIdNumber: Int, completionHandler: @escaping (AFDataResponse<[FeedbackResult]>) -> Void) {
         let requestModel = GetFeedback(baseURL: baseUrl, productIdNumber: productIdNumber)
         self.request(request: requestModel,
                      completionHandler: completionHandler)
     }

     func addFeedback(feedback: FeedbackResult, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
         let requestModel = AddFeedback(baseURL: baseUrl, feedback: feedback)
         self.request(request: requestModel,
                      completionHandler: completionHandler)
     }

     func removeFeedback(feedback: FeedbackResult, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
         let requestModel = RemoveFeedback(baseURL: baseUrl, feedback: feedback)
         self.request(request: requestModel,
                      completionHandler: completionHandler)
     }
 }

 extension Feedback {

     struct GetFeedback: RequestRouter {
         let baseURL: URL
         let method: HTTPMethod = .post
         let path: String = "getFeedback.json"
         let productIdNumber: Int

         var parameters: Parameters? {
             return [
                 "itemId": productIdNumber
             ]
         }
     }
 }

 extension Feedback {

     struct AddFeedback: RequestRouter {
         let baseURL: URL
         let method: HTTPMethod = .post
         let path: String = "addFeedback.json"
         let feedback: FeedbackResult


         var parameters: Parameters? {
             return [
                 "userId": feedback.userId ?? 0,
                 "text": feedback.feedbackText ?? ""
             ]
         }
     }
 }

 extension Feedback {

     struct RemoveFeedback: RequestRouter {
         let baseURL: URL
         let method: HTTPMethod = .post
         let path: String = "removeFeedback.json"
         let feedback: FeedbackResult


         var parameters: Parameters? {
             return [
                 "userId": feedback.userId ?? 0,
                 "text": feedback.feedbackText ?? ""
             ]
         }
     }
 }
