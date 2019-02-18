//
//  ProfilePictureProgressView.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class ProfilePictureProgressView: UIView {

    // MARK: - Properties
    
    var circleProgressLayer : CircularProgress?
    
    // MARK: - Outlets
    
    @IBOutlet weak var profilePicture : UIImageView!
    
    // MARK: - Views Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        circleProgressLayer = CircularProgress(center: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
                                               radius: (self.frame.size.width/2) - 8,
                                               color: UIColor.reachGreen, startAngle: 150, endAngle: 30)
        self.layer.addSublayer(circleProgressLayer!)
    }
    
    func animateProgress() {
        circleProgressLayer?.animate(duration: 1)
    }
}
