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
    override func viewDidLoad() {
        super.viewDidLoad()
        LLBDataFetcher.dataFetcher.fetchPicsForTag("ifoundawesome", success: { [weak self] (group: [LLBPhotoFeed]!) in
            self?.feedGroup = group
        }) { (error: NSError!) in
                print(error.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
