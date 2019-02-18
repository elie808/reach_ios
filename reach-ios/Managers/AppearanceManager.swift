//
//  AppearanceManager.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/14/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import SVProgressHUD

final class UIAppearanceManager {
    
    static func customize() {
        
        // Status Bar Appearance
//        UIApplication.shared.statusBarStyle = .lightContent
        
        // UITabBarItem Appearance
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.reachBlack], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.reachBlack], for: .selected)
        
        // UIBarButtonItem Appearance
//        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.white
        
        // UISearchBar Appearance
//        UISearchBar.appearance().tintColor = UIColor.reachBlack
//        UISearchBar.appearance().barTintColor = UIColor.reachBlack
        
        // UITabBar Appearance
//        UITabBar.appearance().tintColor = UIColor.reachBlack
//        UITabBar.appearance().barTintColor = UIColor.white
//        UITabBar.appearance().unselectedItemTintColor = UIColor.tabItemTitleTint
        
        // UINavigationBar Appearance
//        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//        UINavigationBar.appearance().barTintColor = UIColor.reachBlack
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().barStyle = .black
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
        
        // SVProgressHUD Appearance
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setForegroundColor(UIColor.reachBlack)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.setHapticsEnabled(true)
    }
}

// MARK: - Extensions

// TODO: Redundant. Needs to be removed, after a codebase refactor
extension UIButton {
    func applyButlrStandardButtonStyle() {
        applyButlrStandardBackgroundViewStyle()
        self.setTitleColor(UIColor.reachBlack, for: .normal)
        self.setTitleColor(UIColor.reachBlack, for: .highlighted)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
    }
}

extension UIView {
    
    func addSlightRoundCorners() {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
    
    func addFlagRoundCorners() {
        self.layer.cornerRadius = 3.0
        self.layer.masksToBounds = true
    }
    
    func addSettingsEntryBordersAndCorners() {
        self.layer.cornerRadius = 4.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1).cgColor
        self.layer.masksToBounds = true
    }
    
    func addRoundedCorners() {
        self.layer.cornerRadius = self.bounds.size.height / 2.0
        self.layer.masksToBounds = true
    }
    
    func applyButlrStandardBackgroundViewStyle() {
        addSlightRoundCorners()
        applyButlrStandardGradient()
    }
    
    func applyButlrStandardGradient() {
        
//        let gradient = CAGradientLayer()
//        gradient.colors = [#colorLiteral(red: 0.9725490196, green: 0.8666666667, blue: 0.8078431373, alpha: 1).cgColor, UIColor.butlrStandardPink.cgColor]
//        gradient.locations = [0.0, 1.0]
//        gradient.frame = self.bounds
//        self.layer.insertSublayer(gradient, at: 0)
    }
}

