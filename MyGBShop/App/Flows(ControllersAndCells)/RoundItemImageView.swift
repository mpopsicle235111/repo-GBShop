//
//  RoundItemImageView.swift
//  MyGBShop
//
//  Created by Anton Lebedev on 30.07.2022.
//

import UIKit

 class RoundItemImageView: UIImageView {

     override func layoutSubviews() {
         self.layer.cornerRadius = self.bounds.width / 2
         let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
         self.isUserInteractionEnabled = true
         self.addGestureRecognizer(tap)
     }

     @objc func tapFunction(sender: UITapGestureRecognizer) {
         UIView.animate(withDuration: 0.50,
                                     delay: 0,
                                     usingSpringWithDamping: 0.25,
                                     initialSpringVelocity: 0.70,
                                     options: [.allowUserInteraction],
                                     animations: {
                                         self.bounds = self.bounds.insetBy(dx: 20, dy: 20)
                                     },
                                     completion: nil)
     }



 }
