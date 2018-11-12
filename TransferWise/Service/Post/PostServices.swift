//
//  PostServices.swift
//  TransferWise
//
//  Created by Nam Nguyen on 4/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation
import RxSwift

class AllPostService: UseCase {

    let repository: PostRepository
    
    init(repository: PostRepository) {
        self.repository = repository
    }
    
    func execute(request: UseCaseRequest) -> Observable<[Post]> {
        return repository.getAllPost()
    }
}

final class PostServiceOperations {
    private var allRemote: AllPostService
    private var allOffline: AllPostService
    
    init(remoteRepo: PostRepository, offlineRepo: PostRepository) {
        self.allRemote = AllPostService(repository: remoteRepo)
        self.allOffline = AllPostService(repository: offlineRepo)
    }
    
    func remoteLoadAllPosts() -> Observable<[Post]> {
        return self.allRemote.execute(request: EmptyUseCaseRequest())
    }
    
    func offlineLoadAllPosts() -> Observable<[Post]> {
        return self.allOffline.execute(request: EmptyUseCaseRequest())
    }
}
