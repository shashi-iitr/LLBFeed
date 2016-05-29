//
//  LLBDataFetcher.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class LLBDataFetcher: NSObject {

    static let dataFetcher = LLBDataFetcher()
    private var photoFeedGroup = LLBPhotoFeedGroup?()
    
    func fetchPicsForTag(tag: String, success:[LLBPhotoFeed] -> Void, failure: NSError -> Void) -> Void {
        let path = "https://api.instagram.com/v1/tags/\(tag)/media/recent/?access_token=\(Storage.accessToken()!)"
// "https://api.instagram.com/v1/users/self/media/recent/"
        print(path)
        Alamofire.request(.GET, path, parameters:nil).responseJSON { response in
            print(response.result.value!)
            self.photoFeedGroup = Mapper<LLBPhotoFeedGroup>().map(response.result.value)! as LLBPhotoFeedGroup
            if let group = self.photoFeedGroup {
                success(group.data! as [LLBPhotoFeed])
            } else {
                let error = NSError.init(domain: "Error", code: 500, userInfo: [kError : "No feed found"])
                failure(error) 
            }
            
        }
    }
}
