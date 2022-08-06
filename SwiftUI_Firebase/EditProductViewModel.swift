//
//  EditProductViewModel.swift
//  SwiftUI_Firebase
//
//  Created by user224607 on 8/6/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class EditProductViewModel {
    private var id: String?
    var name: String = ""
    var description: String = ""
    var code: String = ""
    var price: Double = 0.0
    
    private let db = Firestore.firestore()
    
    func setProduct(product: Product) {
        self.id = product.id
        self.name = product.name
        self.description = product.description
        self.code = product.code
        self.price = product.price
    }
    
    func updateProduct() -> Bool {
        let product = Product(userId: Auth.auth().currentUser!.uid, name: self.name, description: self.description, code: self.code, price: self.price)
        
        let productRef = db.collection(Product.COLLECTION).document(self.id!)
        do {
        try productRef.setData(from: product)
            print("The product has been updated - ID: \(productRef.documentID)")
            return true
        } catch let error {
            print("Error while updating the product: \(error)")
            return false
        }
    }
}

