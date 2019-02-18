//
//  CurvedBottomView.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class CurvedBottomView: UIView {
    
    // MARK: - Properties
    
    let maskLayer: CAShapeLayer = {
        
        let subLayer = CAShapeLayer()
        subLayer.fillRule = CAShapeLayerFillRule.nonZero

        return subLayer
    }()
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        maskLayer.frame = bounds
        setPath()
    }

    // MARK: - Methods
    
    private func commonInit() {
        
        layer.addSublayer(maskLayer)
        maskLayer.frame = bounds
        setPath()
    }
    
    private func setPath() {
        
        let point0 = CGFloat(self.frame.origin.x)
        let point1 = CGFloat(self.frame.height*0.8) //modify free range param to adjust the steepness of side lobes
        let point2 = CGFloat(self.frame.width/2)
        let point3 = CGFloat(self.frame.height)
        let point4 = CGFloat(self.frame.height*0.92)
        let point5 = CGFloat(self.frame.width)
        let point6 = CGFloat(self.frame.width - self.frame.height)
        
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: point0, y: point0))
        bezierPath.addCurve(to: CGPoint(x: point0, y: point1), controlPoint1: CGPoint(x: point0, y: point0), controlPoint2: CGPoint(x: point0, y: point1))
        bezierPath.addCurve(to: CGPoint(x: point2, y: point3), controlPoint1: CGPoint(x: point0, y: point1), controlPoint2: CGPoint(x: point4, y: point3))
        bezierPath.addCurve(to: CGPoint(x: point5, y: point1), controlPoint1: CGPoint(x: point6, y: point3), controlPoint2: CGPoint(x: point5, y: point1))
        bezierPath.addLine(to: CGPoint(x: point5, y: point0))
        bezierPath.addLine(to: CGPoint(x: point0, y: point0))
        bezierPath.close()
        
        maskLayer.path = bezierPath.cgPath
        
        self.layer.mask = maskLayer
    }

}

