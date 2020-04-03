//
//  ViewController.swift
//  FaceComparison
//
//  Created by Mark Hawkins on 3/30/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class VCCompareFaces: UIViewController {

    @IBOutlet weak var sourceImage: FCSelectImageView!
    @IBOutlet weak var targetImage: FCSelectImageView!
    
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var similarityText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        sourceImage.owningViewController = self
        targetImage.owningViewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateStackOrientation()
    }
    
    //Get the similarity score based on the two images passes in
    @IBAction func getSimilarityScore() {
        guard let image1 = sourceImage.imageView.image, let image2 = targetImage.imageView.image else { return }

        let spinner = BaseActivitySpinnerController()
        spinner.addTo(viewController: self)

        BCompareFaces.getSimilarityScore(from: image1, comparedTo: image2) { (similarityScore) in
            self.similarityText.text = "Similarity Score: \(String(similarityScore.toDecimal(places: 2)))%"
            spinner.removeFromViewController()
        }
    }
    
    //Rotate stack holding the image views based on the device rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateStackOrientation()
    }
    
    //Update orientation of the Stack holding the images
    func updateStackOrientation() {
        if UIScreen.main.bounds.width < UIScreen.main.bounds.height { stack.axis = .vertical }
        else { stack.axis = .horizontal }
    }
}
