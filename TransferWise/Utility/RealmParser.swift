//
//  RealmParser.swift
//  TransferWise
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class RealmParser:DataParser {
 
    func writeObject<T>(object: T) throws -> T {
        
        guard let item = object as? Object else {
            return object
        }
        
        let realm = try! Realm()
        try realm.write {
            realm.add(item, update: true)
        }
        
        return object
    }
    
    func writeObjects<T>(objects: [T]) throws -> [T] {
        
        guard let items = objects as? [Object] else {
            return objects
        }
        
        let realm = try! Realm()
        try realm.write {
            realm.add(items, update: true)
        }
        
        return objects
    }
}
