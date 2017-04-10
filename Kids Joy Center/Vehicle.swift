//
//  Vehicle.swift
//  Kids Joy Center
//
//  Created by Artis, Justin (CONT) on 3/25/17.
//  Copyright © 2017 Artis, Justin (CONT). All rights reserved.
//

import Foundation
import UIKit

class Vehicle {

    var vehicleImage:UIImageView
    var type: vehicleType
    var correct: Bool
    
    init(image: UIImageView, vType: vehicleType) {
        self.correct = false
        self.vehicleImage = image
        self.type = vType
    }
    
    func getImage() -> UIImageView {
        return self.vehicleImage
    }
    
    func getType() -> vehicleType {
        return self.type
    }
}
