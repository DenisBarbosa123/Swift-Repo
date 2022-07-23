//
//  Product.swift
//  SwiftUI_REST_Client
//
//  Created by user224607 on 7/23/22.
//

import Foundation

struct Product: Codable {
    let id: UInt
    let name: String
    let description: String
    let code: String
    let price: Double
}
