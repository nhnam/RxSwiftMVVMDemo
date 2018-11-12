//
//  PostDetailViewController.swift
//  TransferWise
//
//  Created by Nam Nguyen on 12/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import UIKit

public class PostViewModel {
    private var post: Post!
    init(post: Post) {
        self.post = post
    }
}

final class PostDetailViewController: UIViewController {
    var viewModel: PostViewModel!
}
