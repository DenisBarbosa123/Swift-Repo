//
//  EditProductViewModel.swift
//  SwiftUI_REST_Client
//
//  Created by user224607 on 7/23/22.
//

import Foundation

class EditProductViewModel {
    private var id: UInt = 0
    private var originalCode: String = ""
    
    var name: String = ""
    var description: String = ""
    var code: String = ""
    var price: Double = 0.0
    
    func setProduct(product: Product){
        self.id = product.id
        self.name = product.name
        self.description = product.description
        self.originalCode = product.code
        self.code = product.code
        self.price = product.price
    }
    
    func updateProduct(completion: @escaping (Product?) -> Void){
        let product = Product(id: self.id, name: self.name, description: self.description, code: self.code, price: self.price)
        
        SalesProviderClient.sharedInstance.updateProduct(productCode: self.originalCode, product: product){
            product in
            completion(product)
        }
    }
}
