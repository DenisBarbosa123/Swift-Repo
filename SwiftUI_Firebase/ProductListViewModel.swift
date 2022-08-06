//
//  ProductListViewModel.swift
//  SwiftUI_Firebase
//
//  Created by user224607 on 8/6/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ProductListViewModel: ObservableObject {
    @Published var products = [Product]()
    
    private let db = Firestore.firestore()
    
    func deleteProduct(product: Product, completion: @escaping (Bool) -> Void) { db.collection(Product.COLLECTION).document(product.id!).delete() { error in
            if let error = error {
                print("Error while removing the product: \(error)")
                completion(false)
            } else {
                print("Product successfully removed!")
                completion(true)
            }
        }
    }
    
    func fetchProducts(){
        print("Requesting the product list")
        db.collection(Product.COLLECTION)
            .whereField(Product.USER_ID, isEqualTo: Auth.auth().currentUser!.uid)
            .order(by: Product.NAME)
            .addSnapshotListener {
                querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents \(error)")
                    return
                }
                print("Products list received")
                self.products = documents.compactMap{
                    queryDocumentSnapshot -> Product? in
                    return try? queryDocumentSnapshot.data(as: Product.self)
                }
            }
        print("Products list has been requested")
    }
    
    func clearProducts(){
        products = [Product]()
    }
}
