//
//  UseCase.swift
//  TransferWise
//
//  Created by Nam Nguyen on 4/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation

protocol UseCaseRequest {
    
}

struct EmptyUseCaseRequest: UseCaseRequest {
    
}

protocol UseCase {
    associatedtype Element
    func execute(request: UseCaseRequest) -> Element
}
