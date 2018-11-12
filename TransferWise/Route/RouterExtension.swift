//
//  RouterExtension.swift
//  TransferWise
//
//  Created by Nam Nguyen on 10/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation

// Injection helper
public protocol Initializable { init() }

open class RuntimeInjectable: NSObject, Initializable {
    public required override init() {}
}

public func appNavigationFromString(_ appNavigationClassString: String) -> AppNavigation {
    let appNavClass = NSClassFromString(appNavigationClassString) as! RuntimeInjectable.Type
    let appNav = appNavClass.init()
    return appNav as! AppNavigation
}
