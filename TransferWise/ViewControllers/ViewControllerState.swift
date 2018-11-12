//
//  ViewControllerState.swift
//  TransferWise
//
//  Created by Nam Nguyen on 10/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

enum ViewControllerState: Equatable {
    case isLoading
    case dataAvailable
    case noData(message: String)
}
