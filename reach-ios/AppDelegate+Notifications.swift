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

let oneSignalAppID = "4b5535c7-4e14-4ae1-89aa-97577bc469df"
let oneSignalAPIKey = "ZjYxY2UyMDktMTg2ZS00MTQyLWIwMTItNGIwMDViMDNjYjU1"

extension AppDelegate {
    
    func configureOneSignal(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        OneSignal.initWithLaunchOptions(launchOptions, appId: oneSignalAppID, handleNotificationAction: nil, settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification
        
        // Recommend moving the below line to prompt for push after informing the user about how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        #if DEBUG
        // Print full message.
        print(userInfo)
        #endif
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        #if DEBUG
        // Print full message.
        print(userInfo)
        #endif

        completionHandler(UIBackgroundFetchResult.newData)
    }
}

//extension AppDelegate : MessagingDelegate {
//
//    func configureFirebase(_ application: UIApplication) {
//
        // Use Firebase library to configure APIs
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
//
//        if #available(iOS 10.0, *) {
//
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization( options: authOptions, completionHandler: {_, _ in })
//
//        } else {
//
//            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//        }
//
//        application.registerForRemoteNotifications()
//    }
    
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        #if DEBUG
//        print("--")
//        print("fcmToken:")
//        print(fcmToken)
//        print("--")
//        #endif
//        let postParameters = [
//            "deviceToken" : fcmToken
//        ]
//
//        API.request(Endpoints.updateToken(JSON(postParameters)).endpoint) { (result, isFromCache) in
//        }
//    }
//}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        #if DEBUG
        // Print full message.
        print(userInfo)
        #endif

        completionHandler([.alert,.sound,.badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo

        #if DEBUG
        // Print full message.
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

