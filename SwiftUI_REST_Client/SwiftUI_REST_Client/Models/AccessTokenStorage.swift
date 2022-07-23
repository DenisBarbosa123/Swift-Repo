//
//  AccessTokenStorage.swift
//  SwiftUI_REST_Client
//
//  Created by user224607 on 7/23/22.
//

import Foundation

class AccessTokenStorage {
    var accessToken: String
    var expiresDate: NSDate
    
    init(accessToken: String, expiresDate: Int) {
        self.accessToken = accessToken
        self.expiresDate = NSDate().addingTimeInterval(TimeInterval(expiresDate))
    }
    
    func isValidToken() -> Bool {
        if(NSDate().timeIntervalSinceReferenceDate < self.expiresDate.timeIntervalSinceReferenceDate){
            return true
        }
        return false
    }
}
