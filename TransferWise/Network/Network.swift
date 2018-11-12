//
//  File.swift
//  TransferWise
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum Network {
    case posts
}

extension Network: TargetType {
    var baseURL: URL {
        return Environment.rootURL
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .posts: return Moya.Method.get
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"];
    }
    
    var sampleData: Data {
        return "[]".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return Task.requestPlain
    }
    
    var validationType: ValidationType {
        return .none
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding()
    }
    
}

let provider = MoyaProvider<Network>()
