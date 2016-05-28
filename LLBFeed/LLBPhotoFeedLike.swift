//
//  LLBPhotoFeedLike.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import ObjectMapper

class LLBPhotoFeedLike: Mappable {
    var count: Int?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        count     <- map["count"]
    }
}
