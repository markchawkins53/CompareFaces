//
//  CompareFacesResponse.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/30/20.
//  Copyright © 2020 revature. All rights reserved.
//

//Data struct for compare face data to be input
struct CompareFaceData: Codable {
    var SourceImageFace: CFDSourceImageFace
    var FaceMatches: [CFDFaceMatches]
    //var UnmatchedFaces: []
}

struct CFDSourceImageFace: Codable {
    var BoundingBox: CFDBoundingBox
    var Confidence: Float
}

struct CFDBoundingBox: Codable {
    var Width: Float
    var Height: Float
    var Left: Float
    var Top: Float
}


//Matched Faces Data
struct CFDFaceMatches: Codable {
    var Similarity: Float
    var Face: CFDFace
}

struct CFDFace: Codable {
    var BoundingBox: CFDBoundingBox
    var Confidence: Float
    var Landmarks: [CFDLandmarks]
    var Pose: CFDPose
    var Quality: CFDQuality
}

struct CFDLandmarks: Codable {
    var `Type`: String
    var X: Float
    var Y: Float
}

struct CFDPose: Codable {
    var Roll: Float
    var Yaw: Float
    var Pitch: Float
}

struct CFDQuality: Codable {
    var Brightness: Float
    var Sharpness: Float
}
