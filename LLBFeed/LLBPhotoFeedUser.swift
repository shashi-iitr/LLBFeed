//
//  LLBPhotoFeedUser.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import ObjectMapper

class LLBPhotoFeedUser: Mappable {
    var userID: Int?
    var fullName: String?
    var profilePicture: String?
    var userName: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        userID          <- map["id"]
        fullName        <- map["full_name"]
        userName        <- map["username"]
        profilePicture  <- map["profile_picture"]
    }
}