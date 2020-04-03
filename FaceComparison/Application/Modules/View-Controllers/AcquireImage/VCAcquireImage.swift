//
//  AcquireImage.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/31/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit
import os.log

class VCAquireImage: UIImagePickerController {

    var imageView: UIImageView!
    var button: UIButton!
    
    //Return selected image from source
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Cancel selecting an image from a source
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension VCAquireImage: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Alert to choose whether to get an image from the camera or from the photo library
    func getImageFromSource(on viewController: UIViewController, appliedTo imageView: UIImageView) {
        self.delegate = self
        self.imageView = imageView
        
        let alert = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .alert)
        
        //Access Camera for an image
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            //Check if the device has a camera to use
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                //Request Permission to use Camera and continue code if permission is given
                RequestPermission.camera(viewController) {
                    DispatchQueue.main.async {
                        self.sourceType = .camera
                        viewController.present(self, animated: true, completion: nil)
                    }
                }
            }
            else {
                os_log(AcquireImageError.NoCameraAvailable, log: OSLog.default, type: .error)
            }
        }))
        
        //Access Photo Library for an image
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in

            //Request Permission to use Photo Library and continue code if permission is given
            RequestPermission.photoLibrary(viewController) {
                DispatchQueue.main.async {
                    self.sourceType = .photoLibrary
                    viewController.present(self, animated: true, completion: nil)
                }
            }
        }))
        
        //Cancel selection alert
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
}
