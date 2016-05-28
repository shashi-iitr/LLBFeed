//
//  LLBPhotoFeedImage.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import ObjectMapper

class LLBPhotoFeedImage: Mappable {
    var thumbnail: LLBPhotoFeedImageResolution?
    var lowResolution: LLBPhotoFeedImageResolution?
    var standardResolution: LLBPhotoFeedImageResolution?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        thumbnail           <- map["thumbnail"]
        lowResolution       <- map["low_resolution"]
        standardResolution  <- map["standard_resolution"]
    }

}