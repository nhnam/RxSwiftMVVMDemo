//
//  ErrorHandler.swift
//  TransferWise
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation
import Moya_ModelMapper
import Moya

enum ErrorHandler: Swift.Error {
    
    case none
    
    static func handle( error: Swift.Error, response: Moya.Response ) -> Swift.Error {
        
        if case MoyaError.underlying(let error, _) = error {
            print(error)
            
        } else if case MoyaError.jsonMapping(let response) = error {
            print("ERROR: \(error). jsonMapping, response: \(response)")
            
        } else if case MoyaError.statusCode(let response) = error {
            print("ERROR: \(error). .statusCode, response: \(response)")
            
        } else if case MoyaError.requestMapping(let val) = error {
            print("ERROR: \(error). requestMapping, Enpoint: \(val)")
            
        }
        
        return error
    }
}
