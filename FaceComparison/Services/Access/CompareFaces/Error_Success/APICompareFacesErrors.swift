//
//  APIErrors.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/30/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct CompareFacesErrorMessage {
    static let Conversion: StaticString = "Failed to convert %s to base64"
    static let Retrieval: StaticString = "Failed to retrieve data from comparing faces. ERROR: %s"
    static let NoErrorAvailable: StaticString = "No Error is available comparing faces"
}
