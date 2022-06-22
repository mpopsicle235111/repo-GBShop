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
        let user = User(id: 001,
                        login: "Jack007",
                        firstName: "Jack",
                        lastName: "Abramoff",
                        password: "sourCream2!",
                        email: "jackabramoff@aol.com",
                        gender: "m",
                        creditCardNumber: "1234567812345678",
                        tagLine: "Money rule the world!")

        auth.login(userName: "Jack007", password: "sourCream2!") { response in
                switch response.result {
                case .success(let result):
                        print(result)
                case .failure(let error):
                        print(error.localizedDescription)
                }
        }

        auth.logout(userID: user.id) { response in
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

