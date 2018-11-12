//
//  OfflinePostImplementation.swift
//  TransferWise
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

final class OfflinePostRepository: PostRepository {
    func getAllPost() -> Observable<[Post]> {
        return Observable.create({ (observer) -> Disposable in
            do {
                let realm = try Realm()
                let posts:[Post] = realm.objects(Post.self).map { item -> Post in
                    return item
                }
                observer.on(.next(posts))
                
            } catch ( let error ) {
                observer.on(.error(error))
            }
            observer.on(.completed)
            return Disposables.create()
        })
    }
}
