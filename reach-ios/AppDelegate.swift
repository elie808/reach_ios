//
//  AppDelegate.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/13/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        configureFirebase(application)
        setupApp()
        setupRootViewController()
        
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    //TODO: Temp method. Should probably move somewhere else
    func sendOneSignalID() {
        
        let pushObj = PushNotification(id : "", onesignal_id: nil)
        
        let oneSignal = Resource<PushNotification>(url: URL(string: NetworkingConstants.oneSignalID)!, method: HttpMethod<PushNotification>.post(pushObj))
        URLSession.shared.load(oneSignal) { (response, status) in
            // response =
            // {
            //    "onesignal_id": "tester"
            // }
        }
    }
}

extension AppDelegate {
    
    func setupApp() {
         UIAppearanceManager.customize()
    }
    
    func setupRootViewController() {
        
        if AuthenticationManager.isAuthenticated == true {
            
            let storyBoard : UIStoryboard = UIStoryboard.Main
            window?.rootViewController = storyBoard.instantiateViewController(withIdentifier: ViewIdentifier.MainTab.rawValue)
            
        } else {
            
            let storyBoard : UIStoryboard = UIStoryboard.Login
            window?.rootViewController = storyBoard.instantiateViewController(withIdentifier: ViewIdentifier.LoginNav.rawValue)
        }
    }
}
