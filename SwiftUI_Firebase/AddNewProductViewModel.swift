//
//  AddNewProductViewModel.swift
//  SwiftUI_Firebase
//
//  Created by user224607 on 8/6/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AddNewProductViewModel {
    var name: String = ""
    var description: String = ""
    var code: String = ""
    var price: Double = 0.0
    
    private let db = Firestore.firestore()
    
    func saveNewProduct() -> Bool {
        let product = Product(userId: Auth.auth().currentUser!.uid, name: self.name, description: self.description, code: self.code, price: self.price)
        let newProductRef = db.collection(Product.COLLECTION).document()
        
        do{
            try newProductRef.setData(from: product)
            print("the new product has been saved - ID: \(newProductRef.documentID)")
            return true
        } catch let error {
            print ("Error while saving new product: \(error)")
            return false
        }
    }
}
