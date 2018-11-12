//
//  PostItemCell.swift
//  TransferWise
//
//  Created by Nam Nguyen on 4/10/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import UIKit

class PostItemCell: UITableViewCell {

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func layout(with post: Post?) {
        if let post = post {
            titleLabel.text = post.title?.capitalized
            bodyLabel.text = post.body?.capitalized
        }
    }
}
