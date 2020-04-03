//
//  APICompareFaces.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/30/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Alamofire
import UIKit
import os.log

class APICompareFaces {
    
    static var compressionQuality: CGFloat = 0.3
    
    static func compare(sourceImage image1: UIImage, toTargetImage image2: UIImage, completion: @escaping (CompareFaceData?) -> Void) {
        
        guard let photoSource = image1.toBase64(compressionQuality) else {
            os_log(CompareFacesErrorMessage.Conversion, log: OSLog.default, type: .error, "sourceImage")
            completion(nil)
            return
        }
        
        guard let photoTarget = image2.toBase64(compressionQuality) else {
            os_log(CompareFacesErrorMessage.Conversion, log: OSLog.default, type: .error, "targetImage")
            completion(nil)
            return
        }
        
        os_log(CompareFacesSuccessMessage.Conversion, log: OSLog.default, type: .info)
        
        let compareFaces = FCImages(photo_source: photoSource, photo_target: photoTarget)
        
        AF.request(
            APIEndPoint.faceComparison,
            method: .post,
            parameters: compareFaces,
            encoder: JSONParameterEncoder.default,
            headers: APIHeader.base
        ).validate().responseDecodable(of: CompareFaceData.self) { (response) in
            guard let data = response.value else {
                if let responseError = response.error?.errorDescription {
                    os_log(CompareFacesErrorMessage.Retrieval, log: OSLog.default, type: .error, responseError)
                }
                else {
                    os_log(CompareFacesErrorMessage.Retrieval, log: OSLog.default, type: .error, CompareFacesErrorMessage.NoErrorAvailable.description)
                }
                completion(nil)
                return
            }
            
            os_log(CompareFacesSuccessMessage.Retrieval, log: OSLog.default, type: .info)
            completion(data)
            return
        }
    }
}
