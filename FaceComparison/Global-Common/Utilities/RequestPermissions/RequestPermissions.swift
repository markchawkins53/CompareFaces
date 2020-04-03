//
//  RequestPermissions.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 4/2/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import os.log

class RequestPermission {
    static func camera(_ viewController: UIViewController, completion: @escaping () -> ()) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { (status) in
                    if status { completion() }
                }
            case .restricted, .denied:
                viewController.present(self.errorAlert(accessItem: .Camera), animated: true, completion: nil)
            case .authorized:
                completion()
            @unknown default:
                os_log(RequestPermissionErrors.UnknownStatusType, log: OSLog.default, type: .error, "Camera")
        }
    }
    
    static func photoLibrary(_ viewController: UIViewController, completion: @escaping () -> ()) {
        switch PHPhotoLibrary.authorizationStatus() {
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized { completion() }
            }
        case .restricted, .denied:
            viewController.present(self.errorAlert(accessItem: .PhotoLibrary), animated: true, completion: nil)
        case .authorized:
            completion()
        @unknown default:
            os_log(RequestPermissionErrors.UnknownStatusType, log: OSLog.default, type: .error, "Photo Library")
        }
    }
}

extension RequestPermission {
    enum AccessItem: String {
        case Camera = "Camera"
        case PhotoLibrary = "Photo Library"
    }
    
    static func errorAlert(accessItem: AccessItem) -> UIAlertController {
        let alert = UIAlertController(title: "\(accessItem.rawValue) Permissions", message: "Please go to settings and accept \(accessItem.rawValue) usage", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        return alert
    }
}
