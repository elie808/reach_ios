//
//  AppDelegate+Notifications.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/26/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation
import UIKit
import OneSignal
import SwiftyUserDefaults

let oneSignalAppID = "4b5535c7-4e14-4ae1-89aa-97577bc469df"
let oneSignalAPIKey = "ZjYxY2UyMDktMTg2ZS00MTQyLWIwMTItNGIwMDViMDNjYjU1"

extension AppDelegate {
    
    func configureOneSignal(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
//        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: true]
//        
//        OneSignal.initWithLaunchOptions(launchOptions, appId: oneSignalAppID, handleNotificationAction: nil, settings: onesignalInitSettings)
//        
//        print("Push notificatio STATE: ")
//        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
//        
//        let hasPrompted = status.permissionStatus.hasPrompted
//        print("hasPrompted = \(hasPrompted)")
//        let userStatus = status.permissionStatus.status
//        print("userStatus = \(userStatus)")
//        
//        let isSubscribed = status.subscriptionStatus.subscribed
//        print("isSubscribed = \(isSubscribed)")
//        let userSubscriptionSetting = status.subscriptionStatus.userSubscriptionSetting
//        print("userSubscriptionSetting = \(userSubscriptionSetting)")
//        let userID = status.subscriptionStatus.userId
//        print("userID = \(userID ?? "")")
//        let pushToken = status.subscriptionStatus.pushToken
//        print("pushToken = \(String(describing: pushToken))")
//
//        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        #if DEBUG
        print("-- didReceiveRemoteNotification")
        print(userInfo)
        #endif
    }

    // THIS IS RECEIVING
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     
        #if DEBUG
        print("-- didReceiveRemoteNotification | fetchCompletionHandler")
        print(userInfo)
        #endif

        completionHandler(UIBackgroundFetchResult.newData)
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo

        #if DEBUG
        print("-- userNotificationCenter | willPresent notification")
        print(userInfo)
        #endif

        completionHandler([.alert,.sound,.badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo

        #if DEBUG
        print("-- userNotificationCenter | didReceive response")
        print(userInfo)
        #endif

        //TODO: Show Notificaitons
        showNotifications()
        completionHandler()
    }

    func showNotifications() {

//        let notificationsViewController = UIStoryboard.UserAccount.instantiateViewController(withIdentifier: NotificationsViewController.className) as! NotificationsViewController

//        if let tabController = tabBarController {
//            tabController.selectedIndex = 3
//
//            let navController = tabController.viewControllers![3] as! UINavigationController
//            navController.pushViewController(notificationsViewController, animated: true)
//        }

    }
}

