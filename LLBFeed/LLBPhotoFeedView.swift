//
//  LLBPhotoFeedView.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class LLBPhotoFeedView: UIView {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3
        photoView.layer.masksToBounds = true
        photoView.layer.cornerRadius = 3
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
    
    func configureViewWithPhotoFeed(photoFeed: LLBPhotoFeed?) -> Void {
        photoView.setCachedImageWithURLString(photoFeed?.image?.standardResolution?.urlStr, placeholderType: .Item)
        profileImageView.setCachedImageWithURLString(photoFeed?.user?.profilePicture, placeholderType: .Profile)
        likeLabel.text = "\((photoFeed?.like?.count)!)"
        commentLabel.text = "\((photoFeed?.comments?.count)!)"
        userNameLabel.text = photoFeed?.user?.userName
        userFullNameLabel.text = photoFeed?.user?.fullName
        likeImageView.image = UIImage.likeImage((photoFeed?.hasUserLiked)!)
    }
}
