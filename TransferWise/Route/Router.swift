//
//  Router.swift
//  TransferWise
//
//  Created by Nam Nguyen on 10/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import UIKit

public protocol IsRouter {
    func setupAppNavigation(appNavigation: AppNavigation)
    func navigate(_ navigation: Navigation, from: UIViewController)
    func didNavigate(block: @escaping (Navigation) -> Void)
    var appNavigation: AppNavigation? { get }
}

public class Router {
    public static let `default`:IsRouter = DefaultRouter()
}

public extension UIViewController {
    public func navigate(_ navigation: Navigation) {
        Router.default.navigate(navigation, from: self)
    }
}

public class DefaultRouter: IsRouter {
    
    public var appNavigation: AppNavigation?
    var didNavigateBlocks = [((Navigation) -> Void)] ()
    
    public func setupAppNavigation(appNavigation: AppNavigation) {
        self.appNavigation = appNavigation
    }
    
    public func navigate(_ navigation: Navigation, from: UIViewController) {
        if let toVC = appNavigation?.viewcontrollerForNavigation(navigation: navigation) {
            appNavigation?.navigate(navigation, from: from, to: toVC)
            for b in didNavigateBlocks {
                b(navigation)
            }
        }
    }
    
    public func didNavigate(block: @escaping (Navigation) -> Void) {
        didNavigateBlocks.append(block)
    }
}
