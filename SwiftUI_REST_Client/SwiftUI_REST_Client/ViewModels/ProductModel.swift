//
//  ProductModel.swift
//  SwiftUI_REST_Client
//
//  Created by user224607 on 7/23/22.
//

import Foundation

class ProductModel {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var id: UInt {
        return self.product.id
    }
    
    var name: String {
        return self.product.name
    }
    
    var code: String {
        return self.product.code
    }
    
    var description: String {
        return self.product.description
    }
    
    var price: Double {
        return self.product.price
    }
}
