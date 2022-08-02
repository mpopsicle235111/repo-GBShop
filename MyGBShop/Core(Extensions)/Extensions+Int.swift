//
//  Extensions+Int.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 30.07.2022.
//

//This extension is necessary to use "formattedString" in "configure" func in CatalogueTableViewcell class
import Foundation

 extension Int {
     var formattedString: String {
         let formatter = NumberFormatter()
         formatter.numberStyle = .decimal
         formatter.maximumFractionDigits = 2
         formatter.locale = Locale(identifier: "en_GB")

         let number = NSNumber(value: self)
         let formattedValue = formatter.string(from: number)!
         return "\(formattedValue)"
     }
 }
