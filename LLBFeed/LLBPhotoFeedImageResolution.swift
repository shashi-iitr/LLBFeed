//
//  LLBPhotoFeedImageResolution.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import ObjectMapper

class LLBPhotoFeedImageResolution: Mappable {
    var imageHeight: Int?
    var urlStr: String?
    var imageWidth: Int?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        imageHeight     <- map["height"]
        urlStr          <- map["url"]
        imageWidth      <- map["width"]
    }
}