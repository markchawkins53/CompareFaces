//
//  Endpoints.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/30/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct APIEndPoint {
    static private let url: String = "https://hzcb5v6y4d.execute-api.us-east-2.amazonaws.com/live_test/"
    
    static var faceComparison: String {
        return url + "comparefaces"
    }
}
