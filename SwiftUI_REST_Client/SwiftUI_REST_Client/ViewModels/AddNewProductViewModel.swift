//
//  AddNewProductViewModel.swift
//  SwiftUI_REST_Client
//
//  Created by user224607 on 7/23/22.
//

import Foundation

class AddNewProductViewModel{
    var name: String = ""
    var description: String = ""
    var code: String = ""
    var price: Double = 0.0
    
    func saveNewProduct(completion: @escaping (Product?) -> Void){
        let product = Product(id: 0, name: self.name, description: self.description, code: self.code, price: self.price)
        SalesProviderClient.sharedInstance.createProduct(product: product){ product in
            completion(product)
        }
    }
}
