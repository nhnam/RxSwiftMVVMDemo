//
//  StoryboardHelper.swift
//  TransferWise
//
//  Created by Nam Nguyen on 12/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import UIKit

class StoryboardHelper {
    class func viewController(name identifierName:String, inStoryboard storyboardName: String) -> UIViewController? {
        guard let board = UIStoryboard(name: storyboardName, bundle: nil) as UIStoryboard? else {
            return nil
        }
        return board.instantiateViewController(withIdentifier: identifierName)
    }
}

enum AppStoryboard : String {
    
    case Main
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

