//
//  LLBConstants.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

let kClientSecretKey = "9d58c739c53c410a80ef5d1fdd5a11c0"
let kClientID        = "cd4950693b0d4d3a8e8fcf4a857c6dce"
let kRedirectURL     = "https://lbb.in/delhi/";
let kLoginState      = "kLoginState"
let kAccessToken     = "kAccessToken"
let kAuthURL         = "https://api.instagram.com/oauth/authorize/?client_id=\(kClientID)&redirect_uri=\(kRedirectURL)&response_type=token&scope=likes+comments+basic"

let UserDidLoginViaInstaGramNotificaiton = "UserDidLoginViaInstaGramNotificaiton"

enum LoginState: Int {
    case loggedIn, loggedOut
}

class LLBConstants: NSObject {

}
