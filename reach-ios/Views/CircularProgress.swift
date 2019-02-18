//
//  CircularProgress.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class CircularProgress: CAShapeLayer {
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Start/End angles are in Degrees
    init(center: CGPoint, radius: CGFloat, color: UIColor, startAngle: CGFloat, endAngle: CGFloat) {
        super.init()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: (startAngle * CGFloat.pi / 180), endAngle: (endAngle * CGFloat.pi / 180), clockwise: true)
        
        self.path = circularPath.cgPath
        self.strokeColor = color.cgColor
        self.fillColor = UIColor.clear.cgColor
        self.lineWidth = 6
        
        self.lineCap = CAShapeLayerLineCap.round
        
        self.strokeEnd = 0
    }
    
    func animate(duration: Double) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.toValue = 1
        basicAnimation.duration = duration
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        self.add(basicAnimation, forKey: "WhateverKeyr")
    }
}
