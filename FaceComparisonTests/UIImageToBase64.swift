//
//  UIImageToBase64.swift
//  FaceComparisonTests
//
//  Created by Mark Hawkins on 4/2/20.
//  Copyright © 2020 revature. All rights reserved.
//

import XCTest

@testable import FaceComparison

class UIImageToBase64Tests: XCTestCase {
    
    var image: UIImage!
    
    override func setUp() {
        image = UIImage(named: "Mark")
    }
    
    func testCompressionOutOfRange() {
        XCTAssertNil(image.toBase64(-0.1))
        XCTAssertNil(image.toBase64(1.1))
    }
    
    func testConversion() {
        XCTAssertNotNil(image.toBase64(0.5))
    }
    
}
