//
//  UIViewControllerExtension.swift
//  TransferWise
//
//  Created by Nam Nguyen on 16/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import UIKit
import ObjectiveC

private var hasSwizzled: Bool = false
private var firstAppear: Bool = false

private let swizzling:(UIViewController.Type) -> () = { viewController in
    let originalSelector = #selector(viewController.viewWillAppear(_:))
    let swizzledSelector = #selector(viewController.viewShouldAppear(_:))
    guard let originMethod = class_getInstanceMethod(viewController, originalSelector),
        let swizzledMethod = class_getInstanceMethod(viewController, swizzledSelector) else { return }
    
    method_exchangeImplementations(originMethod, swizzledMethod)
}

extension UIViewController {
    public class func swizzle() {
        guard !hasSwizzled else { return }
        
        hasSwizzled = true
        
        swizzling(UIViewController.self)
    }
    
    var isFirstAppear: Bool {
        get {
            if let obj = objc_getAssociatedObject(self, &firstAppear) as? Bool {
                return obj
            } else {
                objc_setAssociatedObject(self, &firstAppear, false, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return false
            }
        }
        set {
            objc_setAssociatedObject(self, &firstAppear, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc internal func viewShouldAppear(_ animated: Bool) {
        guard !isFirstAppear else { return }
        
        isFirstAppear = true
        
        let selector = #selector(viewWillAppearOnce)
        guard let _ = class_getInstanceMethod(UIViewController.self, selector) else { return }
        self.perform(selector)
    }
    
    @objc func viewWillAppearOnce() {
        // fatalError("viewWillAppearOnce is not implemented")
    }
}


