//
//  BCompareFaces.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 4/2/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class BCompareFaces {
    static func getSimilarityScore(from sourceImage: UIImage, comparedTo targetImage: UIImage, completion: @escaping (Float) -> Void ) {
        APICompareFaces.compare(sourceImage: sourceImage, toTargetImage: targetImage) { (faceData) in
            if let data = faceData, !data.FaceMatches.isEmpty {
                var highestSimilarity: Float = 0
                
                for match in data.FaceMatches {
                    if match.Similarity > highestSimilarity { highestSimilarity = match.Similarity }
                }
                
                completion(highestSimilarity)
            }
            else {
                completion(0)
            }
        }
    }
}
