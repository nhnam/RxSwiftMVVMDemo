//
//  DataParser.swift
//  TransferWise
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation

protocol DataParser {
    func writeObject<T>(object: T) throws -> T
    func writeObjects<T>(objects: [T]) throws -> [T]
}
