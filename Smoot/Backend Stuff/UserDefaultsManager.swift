//
//  NotificationKeyManager.swift
//  Smoot
//
//  Created by Paul Wiesinger on 30.05.18.
//  Copyright © 2018 73. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    let usernameKey = "usernameKey"
    let eventlistKeys = "eventlistKeys"
    
    
    
    static func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: usernameKey)
    }
}
