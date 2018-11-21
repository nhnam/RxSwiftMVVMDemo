//
//  AppDelegate.swift
//  TransferWise
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UIViewController.swizzle()
        Router.default.setupAppNavigation(appNavigation: AppMainNavigation())
        Router.default.didNavigate { navigation in
            GoogleAnalytics.trackPage(navigation)
        }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Before: \(UserDefaults.standard.dictionaryRepresentation().keys)")
    
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        print("After: \(UserDefaults.standard.dictionaryRepresentation())")
    }
    
}

