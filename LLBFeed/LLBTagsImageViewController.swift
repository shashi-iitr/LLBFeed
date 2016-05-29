//
//  LLBTagsImageViewController.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class LLBTagsImageViewController: UIViewController {
    
    
    var feedGroup = [LLBPhotoFeed]?()
    var photoFeedView: LLBPhotoFeedView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 47/255, green: 47/255, blue: 47/255, alpha: 1)
        let screenSize = UIScreen.mainScreen().bounds.size
        photoFeedView = LLBPhotoFeedView.loadFromNib() as? LLBPhotoFeedView
        photoFeedView?.frame = CGRectMake(1, 1, screenSize.width - 2, screenSize.height - 2)
        self.view .addSubview(photoFeedView!)
        fetchPhotoFeeds()
    }
    
    func fetchPhotoFeeds() -> Void {
        LLBDataFetcher.dataFetcher.fetchPicsForTag("ifoundawesome", success: { [weak self] (group: [LLBPhotoFeed]!) in
            self?.feedGroup = group
            self!.configurePhotoFeedView()
        }) { (error: NSError!) in
            print(error.debugDescription)
        }
    }
    
    func configurePhotoFeedView() -> Void {
        photoFeedView?.configureViewWithPhotoFeed(feedGroup![0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
