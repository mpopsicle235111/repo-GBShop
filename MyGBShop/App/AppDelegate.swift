//
//  AppDelegate.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 19.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //Added for auth
    var window: UIWindow?
    let requestFactory = RequestFactory()

    
    /// Standard func
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Added for auth
        let auth = requestFactory.makeAuthRequestFactory()
        let regist = requestFactory.makeRegistRequestFactory()
        let changeUserData = requestFactory.makeСhangeUserDataFactory()
        
        //Added to get a list of items
        let Catalogue = requestFactory.makeGetCatalogueRequestFactory()
        //Added to get a single selected item
        let ItemById = requestFactory.makeGetItemRequestFactory()
        
        //Added to handle item feedback
        let feedback = requestFactory.makeGetFeedbackRequestFactory()
        
        let user = User(id: 001,
                        login: "Jack007",
                        firstName: "Jack",
                        lastName: "Abramoff",
                        password: "sourCream2!",
                        email: "jackabramoff@aol.com",
                        gender: "m",
                        creditCardNumber: "1234567812345678",
                        tagLine: "Money rule the world!"
                        )
        
        //Added to get a list of items
        let pageNumber = 1
        let categoryNumber = 1
        //Added to get a single selected item
        let productId = 7
        //Added to get feedback
        let feedbackResult = FeedbackResult(userId: 1, feedbackText: "Very cool item", productIdNumber: 1)

        auth.login(userName: "Jack007", password: "sourCream2!") { response in
                switch response.result {
                case .success(let result):
                        print(result)
                case .failure(let error):
                        print(error.localizedDescription)
                }
        }

        auth.logout(userID: user.id ?? 0) { response in
                switch response.result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
                     }
        }

        regist.register(user: user) {response in
                switch response.result {
                    case .success(let result):
                        print(result)
                    case .failure(let error):
                        print(error.localizedDescription)
                }
        }

        changeUserData.changeUserData(user: user) {response in
                switch response.result {
                    case .success(let result):
                         print(result)
                    case .failure(let error):
                         print(error.localizedDescription)
                }
        }
        
        //Added to get a list of items
        Catalogue.getCatalogue(pageNumber: pageNumber,
                                  categoryNumber: categoryNumber) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //Added to get a single selected item
        ItemById.getItem(productIdNumber: productId) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //Added to get feedback from user
        feedback.getFeedback(productIdNumber: productId) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //Added to assign the feedback to item
        feedback.addFeedback(feedback: feedbackResult) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //Added to wipe the feedback from item
        feedback.removeFeedback(feedback: feedbackResult) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        
        return true
    }

    // MARK: UISceneSession Lifecycle - regular func
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    /// Regular function
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}

