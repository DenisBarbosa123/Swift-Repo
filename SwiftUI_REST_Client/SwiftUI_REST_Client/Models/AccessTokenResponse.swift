//
//  AccessTokenResponse.swift
//  SwiftUI_REST_Client
//
//  Created by user224607 on 7/23/22.
//

import Foundation

struct AccessTokenResponse: Decodable {
    let access_token: String
    let refresh_token: String
    let expires_in: Int
}
