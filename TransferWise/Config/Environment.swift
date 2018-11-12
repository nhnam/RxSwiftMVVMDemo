//
//  Environment.swift
//  TransferWise
//
//  Created by Nam Nguyen on 5/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let rootURL = "ROOT_URL"
            static let apiKey = "API_KEY"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let rootURL: URL = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.rootURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
    
    // MARK: - Local information
    static let sandboxDirectory: String = {
        print(NSUserName())
        print(NSFullUserName())
        return NSHomeDirectory()
    }()
}
