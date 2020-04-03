//
//  FloatExtension.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 4/2/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

extension Float {
    func toDecimal(places: Int) -> Float {
        let decimalPlaces = powf(10.0, Float(places))
        let roundedScore = roundf(self * decimalPlaces) / decimalPlaces
        
        return roundedScore
    }
}
