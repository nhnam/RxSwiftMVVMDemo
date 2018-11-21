//
//  ViewController.swift
//  TransferWise
//
//  Created by Nam Nguyen on 3/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, PostPresenterDelegate {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nodataView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var presenter: PostPresenter = {
        return PostPresenter(service: PostServiceOperations(remoteRepo: RemotePostRepository(), offlineRepo: OfflinePostRepository()), delegate:self)
    }()
    
    private var state: ViewControllerState = .isLoading {
        willSet {
            if state == newValue { return }
            switch newValue {
            case .isLoading:
                configurateLoadingView()
                break
            case .noData (let message):
                configurateEmptyView(message: message)
                break
            case .dataAvailable:
                configurateDataView()
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillAppearOnce() {
        fetchPosts()
    }
    
    private func configurateTableView() {
        tableView.register(UINib(nibName: "PostItemCell", bundle: nil), forCellReuseIdentifier: "cellPostItemID")
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }
    
    private func configurateLoadingView() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        tableView.isHidden = true
        nodataView.isHidden = true
    }
    
    private func configurateEmptyView(message: String) {
        nodataView.isHidden = false
        nodataView.text = message
        tableView.isHidden = true
        loadingIndicator.isHidden = true
    }

    private func configurateDataView() {
        tableView.isHidden = false
        loadingIndicator.isHidden = true
        nodataView.isHidden = true
    }
    
    private func fetchPosts() {
        state = .isLoading
        presenter.fetchAllPosts(offlineFirst: true)
    }
    
    // PostPresenterDelegate
    func postsReturn(result: FetchResult<[Post]>, cache: Bool) {
        switch result {
        case .success(_):
            self.state = .dataAvailable
            self.tableView.reloadData()
            break
        case .failure(let error):
            print("Post return with error: \(error.localizedDescription)")
            self.state = .noData(message: error.localizedDescription)
            break
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = presenter.postAt(index: indexPath.row) else { return }
        navigate(PostNavigation.postDetail(post))
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPosts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostItemCell = tableView.dequeueReusableCell(withIdentifier: "cellPostItemID", for: indexPath) as! PostItemCell
        cell.layout(with: presenter.postAt(index: indexPath.row))
        return cell
    }
}
