//
//  LLBStorageExtension.swift
//  LLBFeed
//
//  Created by shashi kumar on 28/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation

let Storage = NSUserDefaults.standardUserDefaults()

extension NSUserDefaults {
    func userLoginState() -> LoginState.RawValue {
        return self.integerForKey(kLoginState)
    }
    
    func setUserLoginState(loginState: LoginState.RawValue) -> Void {
        self.setInteger(loginState, forKey: kLoginState)
    }
    
    func accessToken() -> String? {
        if let token = self.objectForKey(kAccessToken) as? String  {
            return token
        }
        
        return ""
    }
    
    func setAccessToken(accessToken: String) -> Void {
        self.setObject(accessToken, forKey: kAccessToken)
    }
}
