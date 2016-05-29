//
//  LLBPhotoFeed.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import ObjectMapper

class LLBPhotoFeed: Mappable {
    var attribution: String?
    var caption: LLBPhotoFeedCaption?
    var comments: LLBPhotoFeedLike?
    var createdTime: Int?
    var filter: String?
    var identifier: String?
    var image: LLBPhotoFeedImage?
    var like: LLBPhotoFeedLike?
    var link: String?
    var location: String?
    var tags: [String]?
    var type: String?
    var user: LLBPhotoFeedUser?
    var hasUserLiked: Bool?
    var usersInPhoto: [AnyObject]?

    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        attribution     <- map["attribution"]
        caption         <- map["caption"]
        comments        <- map["comments"]
        createdTime     <- map["created_time"]
        filter          <- map["filter"]
        identifier      <- map["id"]
        image           <- map["images"]
        like            <- map["likes"]
        link            <- map["link"]
        location        <- map["location"]
        tags            <- map["tags"]
        type            <- map["type"]
        user            <- map["user"]
        hasUserLiked    <- map["user_has_liked"]
        usersInPhoto    <- map["users_in_photo"]
    }
}
