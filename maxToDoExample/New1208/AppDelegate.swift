//
//  AppDelegate.swift
//  New1208
//
//  Created by 宣齊 on 2018/12/8.
//  Copyright © 2018年 maxlist. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        return true
    }
    

//    func handleIncomingDynamicLink(_ dynamicLink: DynamicLink) {
//        guard let url = dynamicLink.url else {
//
//            print("dyanmic link object has no url")
//            return
//        }
//        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
//            let queryItems = components.queryItems else { return }
//        for queryItem in queryItems {
//            print("Parmeter \(queryItem.name) has a value of \(queryItem.value ?? "")")
//        }
//    }


    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            print("Incoming URL is \(incomingURL)")
            let handleLink = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL, completion: { (dynamicLink, error) in
                if let dynamicLink = dynamicLink, let _ = dynamicLink.url
                {
//                    self.handleIncomingDynamicLink(dynamicLink)
                    let path = dynamicLink.url?.path

                    print("Your Dynamic Link parameter__up: \(dynamicLink)")
                    let get_dynamicLink = dynamicLink.url
                    Analytics.setUserProperty(get_dynamicLink?.absoluteString, forName: "from")
                    

                    if path == "/home" {
                        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
                        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "timer")
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
                        appDelegate.window?.rootViewController = HomeVc
                    }
                    else
                    {
                    // other page
                    }
                } else {
                    // Check for errors
                }
            })
            return handleLink
        }
        return false
        Analytics.setUserProperty("NaN", forName: "from")
    }
    
    
    
    
//    func handleDynamicLink(_ dynamicLink: DynamicLink) {
//        print("Your Dynamic Link parameter: \(dynamicLink)")
//    }

    
//
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
//                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
//
//        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
//                    print(dynamiclink)
//            // ...
//        }
//
//        return handled
//    }
//
//    @available(iOS 9.0, *)
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
//        return application(app, open: url,
//                           sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
//                           annotation: "")
//    }
//
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
//            // Handle the deep link. For example, show the deep-linked content or
//            // apply a promotional offer to the user's account.
//            // ...
//            guard let link = dynamicLink.url else{
//                return true
//            }
//            print("your deep link is:",link.absoluteString)
//            return true
//        }
//        return false
//    }

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


}

