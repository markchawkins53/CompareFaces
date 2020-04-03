//
//  UIImageExtensions.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/30/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import UIKit
import os.log

extension UIImage {
    func toBase64(_ compressionQuality: CGFloat) -> String? {
        if compressionQuality < 0 || 1 < compressionQuality {
            os_log(UIImageErrors.Base64ConversionCompressionQuality, log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let imageData = self.jpegData(compressionQuality: compressionQuality) else {
            os_log(UIImageErrors.Base64ConversionConvertToJPEGData, log: OSLog.default, type: .debug)
            return nil
        }
        
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
