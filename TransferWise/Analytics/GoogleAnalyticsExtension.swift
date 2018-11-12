//
//  GoogleAnalyticsExtension.swift
//  TransferWise
//
//  Created by Nam Nguyen on 10/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Firebase

final class GoogleAnalytics {
    public static func trackPage(_ navigation: Navigation) {
        guard let navigation = navigation as? PostNavigation else { return }
        switch navigation {
        case .listPosts:
            Analytics.logEvent("Page", parameters:["Page_name": "List Post"])
            break
        case .postDetail(_):
            Analytics.logEvent("Page", parameters:["Page_name": "Post Detail"])
            break
        }
        print("Track: \(navigation)")
    }
}
