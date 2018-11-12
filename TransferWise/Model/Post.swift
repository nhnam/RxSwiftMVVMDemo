//
//  Post.swift
//  TransferWise
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation
import RealmSwift
import Mapper

@objcMembers
final class Post: Object, Mappable {
    
    dynamic var id: Int = 0
    dynamic var userId: Int = 0
    dynamic var title: String? = nil
    dynamic var body: String? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init(map: Mapper) throws {
        self.init()
        guard let id:Int = map.optionalFrom("id") else {
            throw NSError(domain: "Post.init", code: -1, userInfo: [NSLocalizedFailureReasonErrorKey:"Object doesn't have id"])
        }
        self.id = id
        self.userId = map.optionalFrom("userId")!
        self.title = map.optionalFrom("title")
        self.body = map.optionalFrom("body")
    }
    
}
