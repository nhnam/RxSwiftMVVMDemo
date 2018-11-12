//
//  AppNavigation.swift
//  TransferWise
//
//  Created by Nam Nguyen on 10/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//
import UIKit

public protocol AppNavigation {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController)
}

