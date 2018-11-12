//
//  AppMainNavigation.swift
//  TransferWise
//
//  Created by Nam Nguyen on 10/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import UIKit

struct AppMainNavigation: AppNavigation {
    
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        
        if let navigation = navigation as? PostNavigation {
            switch navigation {
            case .listPosts:
                guard let listPostsVc =  StoryboardHelper.viewController(name: "ListPostsViewController", inStoryboard: AppStoryboard.Main.rawValue) as? ViewController else {
                    fatalError("ListPostsViewController not found")
                }
                return listPostsVc
            case .postDetail(let post):
                guard let postDetailVc =  StoryboardHelper.viewController(name: "PostDetailViewController", inStoryboard: AppStoryboard.Main.rawValue) as? PostDetailViewController else {
                    fatalError("PostDetailViewController not found")
                }
                let viewModel = PostViewModel(post: post)
                postDetailVc.viewModel = viewModel
                return postDetailVc
            }
        }
        fatalError("\(navigation) is not handled")
    }
    
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        from.navigationController?.pushViewController(to, animated: true)
    }
}
