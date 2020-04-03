//
//  Headers.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/30/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Alamofire

struct APIHeader {
    static var base: HTTPHeaders {
        return [
            "Content-Type" : "application/json"
        ]
    }
}
