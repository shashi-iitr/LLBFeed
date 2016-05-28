//
//  LLBPhotoFeedCaption.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import ObjectMapper

class LLBPhotoFeedCaption: Mappable {
    var createdTime: Int?
    var from: LLBPhotoFeedCaptionFrom?
    var captionID: Int?
    var textStr: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        createdTime     <- map["created_time"]
        from            <- map["from"]
        captionID       <- map["id"]
        textStr         <- map["text"]
    }
}