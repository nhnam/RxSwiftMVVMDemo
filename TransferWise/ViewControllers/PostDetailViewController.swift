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
    
    @IBOutlet weak var loadingIndicatorView: LoadingIndicatorView!
    
    var viewModel: PostViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillAppearOnce() {
        loadingIndicatorView.spin()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.loadingIndicatorView.stop()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
