//
//  ServerConfig.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 27.08.2022.
//
//  Schemes added as per: iOSCoderAdhimanyuDaspan
//  https://www.youtube.com/watch?v=W0uQd6QdnG0
//
//  The idea here is to provide a different environment
//  (Heroku Vapor Server address)
//  to QA, LOCAL, PROD, DEMO and DEV

import Foundation

enum BaseUrl:String {
    case LOCAL = "https://aqueous-fjord-08711.herokuapp.com/"
    case QA = "https://boiling-wildwood-30728.herokuapp.com/"
    
    //Best working version
    case PROD = "https://tranquil-headland-91171.herokuapp.com/"
    
    case DEMO = "https://stark-shelf-26922.herokuapp.com/"
    case DEV = "https://thawing-meadow-23707.herokuapp.com/"
}

class ServerConfig {
    static let shared:ServerConfig = ServerConfig()
    
    var baseUrl:String?
    
    func setUpServerConfig() {
        
        #if LOCAL
        self.baseUrl = BaseUrl.LOCAL.rawValue
        #elseif QA
        self.baseUrl = BaseUrl.QA.rawValue
        #elseif PROD
        self.baseUrl = BaseUrl.PROD.rawValue
        #elseif DEMO
        self.baseUrl = BaseUrl.DEMO.rawValue
        #elseif DEV
        self.baseUrl = BaseUrl.DEV.rawValue
        #endif
        
    }
}

