//
//  LLBPhotoFeedGroup.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import ObjectMapper

class LLBPhotoFeedGroup: Mappable {
    var data: [LLBPhotoFeed]?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        data     <- map["data"]
    }
}
