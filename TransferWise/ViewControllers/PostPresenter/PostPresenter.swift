//
//  PostPresenter.swift
//  TransferWise
//
//  Created by Nam Nguyen on 4/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation
import RxSwift

struct Reachability {
    static var isNetworkAvailable: Bool = true
}

enum FetchResult<U> {
    case success(U)
    case failure(Swift.Error)
}

protocol PostPresenterDelegate: class {
    func postsReturn(result: FetchResult<[Post]>, cache: Bool)
}

public class PostPresenter {
    private var delegate: PostPresenterDelegate?
    private var serviceOperations: PostServiceOperations
    private lazy var dispose:DisposeBag = {
        return DisposeBag()
    }()
    private var posts: [Post] = []
    
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfPosts: Int {
        return posts.count
    }
    
    func postAt(index: Int) -> Post? {
        if index < 0 || index >= posts.count {
            return nil
        }
        return posts[index]
    }
    
    init(service: PostServiceOperations, delegate: PostPresenterDelegate) {
        self.serviceOperations = service
        self.delegate = delegate
    }
    
    func fetchAllPosts(offlineFirst: Bool) {
        let fetch = (offlineFirst || !Reachability.isNetworkAvailable) ? self.fetchOffline : self.fetchOnline
        fetch()
    }
    
    func fetchOffline() {
        serviceOperations.offlineLoadAllPosts().subscribe(onNext: { [weak self] (posts: [Post]) in
            guard let self = self else {  return }
            
            self.posts = posts
            self.delegate?.postsReturn(result: .success(posts), cache: true)
            
            self.fetchOnline()
            
        }, onError: { [weak self] (error) in
            guard let self = self else { return }
            
            self.delegate?.postsReturn(result: .failure(error), cache: true)
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: self.dispose)
    }
    
    func fetchOnline() {
        serviceOperations.remoteLoadAllPosts().subscribe(onNext: { [weak self] (posts: [Post]) in
            guard let self = self else { return }
            
            self.posts = posts
            self.delegate?.postsReturn(result: .success(posts), cache: false)
            
        }, onError: { [weak self] (error) in
            guard let self = self else { return }
            self.delegate?.postsReturn(result: .failure(error), cache: false)
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: self.dispose)
    }
}
