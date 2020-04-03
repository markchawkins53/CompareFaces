//
//  FaceComparisonTests.swift
//  FaceComparisonTests
//
//  Created by Mark Hawkins on 3/30/20.
//  Copyright © 2020 revature. All rights reserved.
//

import XCTest

@testable import FaceComparison

class CompareFacesAPITests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testFaceRetrievalAPI() {
        guard let image1 = UIImage(named: "Mark"), let image2 = UIImage(named: "MarkDL") else { XCTFail(); return }
        
        let expectation = self.expectation(description: "Retrieving")
        
        APICompareFaces.compare(sourceImage: image1, toTargetImage: image2) { (FaceData) in
            guard let data = FaceData else { XCTFail(); return }
            print ("Printing Face Data: \(data)")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }

}
