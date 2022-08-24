//
//  GALogger.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 24.08.2022.
//
// This class was added to enable Google Analytics from Firebase

import Foundation
import FirebaseAnalytics

class GALogger {
    class func logEvent(name: String, key: String, value: String) {
        Analytics.logEvent(name, parameters: [key: value])
    }
}
