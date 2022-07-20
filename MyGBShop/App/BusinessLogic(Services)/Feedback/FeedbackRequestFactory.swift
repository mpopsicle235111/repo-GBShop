//
//  FeedbackRequestFactory.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 21.07.2022.
//

import Alamofire

 protocol FeedbackRequestFactory {
     func getFeedback(productIdNumber: Int, completionHandler: @escaping (AFDataResponse<[FeedbackResult]>) -> Void)

     func addFeedback(feedback: FeedbackResult, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)

     func removeFeedback(feedback: FeedbackResult, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
 }
