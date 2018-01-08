//
//  AppDelegate.swift
//  eventcast
//
//  Created by apple on 30/12/17.
//  Copyright © 2017 jTechAppz. All rights reserved.
//

import UIKit
import UserNotifications
import SystemConfiguration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: AppNavigationController!
    var orientationLock = UIInterfaceOrientationMask.all
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.statusBarStyle = .lightContent
        sleep(0)
        window = UIWindow.init(frame: UIScreen.main.bounds)
        if DataModel.getIsLaunchFirstTime() == "1" {
            let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
            navigationController = AppNavigationController.init(rootViewController: homeVC)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }else {
            let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
            navigationController = AppNavigationController.init(rootViewController: loginVC)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    
        guard  let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as AnyObject).value(forKey: "statusBar") as? UIView else { return true }
        statusBar.backgroundColor = COLOUR_NAV
        
        //let types = UIUserNotificationType(rawValue:UIUserNotificationType.alert.rawValue | UIUserNotificationType.sound.rawValue | UIUserNotificationType.badge.rawValue)
        application.registerForRemoteNotifications()
     //   application.registerUserNotificationSettings(UIUserNotificationSettings(types: types, categories: nil))
      
       // let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        
        return true
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func ShowiInfoCenter() {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
        webVc.url = INFOCENTER_URL
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_INFO_CCENTER
        navigationController.pushViewController(webVc, animated: true)
    }
    func ShowiAgenda() {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_AGENDA
        navigationController.pushViewController(webVc, animated: true)
    }
    func ShowiSpeaker() {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
        
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_SPEAKER
        navigationController.pushViewController(webVc, animated: true)
    }
    func ShowParticipants() {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
       
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_PARTICIPANTS
        navigationController.pushViewController(webVc, animated: true)
    }
    func ShowGallery() {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
       
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_GALLERY
        navigationController.pushViewController(webVc, animated: true)
    }
    func ShowSurveys() {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
     
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_SURVEYS
        navigationController.pushViewController(webVc, animated: true)
    }
    func ShowPolls() {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
   
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_POLLS
        navigationController.pushViewController(webVc, animated: true)
    }
    func ShowDownlaodCenter() {
        let webVc = WebViewController(nibName: "WebViewController",bundle:nil)
        
        webVc.page_type = K_SIDE_MENU.k_SIDE_MENU_DOWNLOAD_CENTER
        navigationController.pushViewController(webVc, animated: true)
    }
    func ShowProfile() {
        let webVc = HomeViewController(nibName: "HomeViewController",bundle:nil)
        navigationController.pushViewController(webVc, animated: true)
    }
    func ShowLogout() {
        let webVc = LoginViewController(nibName: "LoginViewController",bundle:nil)
        DataModel.setIsLaunchFirstTime("")
        navigationController.pushViewController(webVc, animated: true)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        //        Messaging.messaging().appDidReceiveMessage(userInfo)
        print("Notification PayLoad : \(userInfo)")
    }

    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var tokenString: String = ""
        for i in 0..<deviceToken.count { tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]]) }
        print("Device Token: \(tokenString)")
        
    }
    
    internal func registerForPushNotifications(_ application: UIApplication) { application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)) }
    
    //rechability
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
}

