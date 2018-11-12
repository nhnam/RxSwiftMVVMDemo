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
        Router.default.setupAppNavigation(appNavigation: AppMainNavigation())
        Router.default.didNavigate { navigation in
            GoogleAnalytics.trackPage(navigation)
        }
        return true
    }
    
}

