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
    
    var totalPoints : Int = 0
    var maxPoints : Int = 1
    private var circleProgressLayer : CircularProgress?
    
    // MARK: - Outlets
    
    @IBOutlet weak var profilePicture : UIImageView!
    
    // MARK: - Views Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func animateProgress() {
        
        let endAngle : CGFloat = CGFloat(((totalPoints * 180) / maxPoints) - 180)
        
        circleProgressLayer = CircularProgress(center: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
                                               radius: (self.frame.size.width/2) - 8,
                                               color: UIColor.reachGreen, startAngle: 180, endAngle: endAngle)
        
        self.layer.addSublayer(circleProgressLayer!)
        
        circleProgressLayer?.animate(duration: 1)
    }
}
