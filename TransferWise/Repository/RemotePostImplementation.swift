//
//  RemotePostImplementation.swift
//  TransferWise
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation
import Moya
import RxSwift

final class RemotePostRepository: PostRepository {
    func getAllPost() -> Observable<[Post]> {
        return provider.rx.requestWithProgress(.posts).map({ (progressResponse) -> [Post] in
            guard let response = progressResponse.response else { return [] }
            do {
                let mappingResult = try response.filterSuccessfulStatusCodes().map(to: [Post].self)
                return try RealmParser().writeObjects(objects: mappingResult)
            } catch (let error) {
                throw ErrorHandler.handle(error: error, response: response)
            }
        })
    }
}
