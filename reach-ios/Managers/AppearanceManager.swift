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
        SVProgressHUD.setForegroundColor(.reachGreen)
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.setHapticsEnabled(true)
    }
}
