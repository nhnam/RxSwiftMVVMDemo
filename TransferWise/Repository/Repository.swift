//
//  Repository.swift
//  TransferWise
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import Foundation
import RxSwift

protocol PostRepository {
    func getAllPost() -> Observable<[Post]>
}
