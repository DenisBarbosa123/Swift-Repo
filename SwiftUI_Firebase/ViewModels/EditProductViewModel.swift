import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorageUI

class EditProductViewModel {

    private var id: String?
    var name: String = ""
    var description: String = ""
    var code: String = ""
    var price: Double = 0.0
    private var imageId: String?

    private let db = Firestore.firestore()

    func setProduct(product: Product) {
        self.id = product.id
        self.name = product.name
        self.description = product.description
        self.code = product.code
        self.price = product.price
        self.imageId = product.imageId
    }
    
    func updateProduct(newPhoto: Bool, imageData: Data?,
                       completion: @escaping (Bool) -> Void) {
        if newPhoto, let imageData = imageData {
            if let imageId = self.imageId {
                deleteImage(imageId: imageId)
            }
            self.imageId = UUID().uuidString
            saveProductImage(imageData: imageData, imageId: self.imageId!) {
                success in
                
                if success {
                    self.update(imageId: self.imageId) { result in
                        completion(result)
                    }
                } else {
                    completion(false)
                }
            }
        } else {
            update(imageId: self.imageId) { result in
                completion(result)
            }
        }
    }
    
    private func update(imageId: String?,
                        completion: @escaping (Bool) -> Void) {
        let product = Product(userId: Auth.auth().currentUser!.uid,
                              name: self.name,
                              description: self.description,
                              code: self.code,
                              price: self.price,
                              imageId: self.imageId)
        
        let productRef = db.collection(Product.COLLECTION).document(self.id!)

        do {
            try productRef.setData(from: product)
            print("The product has been updated - ID: \(productRef.documentID)")
            completion(true)
        } catch let error {
            print("Error while updating the product: \(error)")
            completion(false)
        }
    }
    
    private func saveProductImage(imageData: Data, imageId: String,
                                  completion: @escaping (Bool) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageRef = storageRef
            .child("/users/\(Auth.auth().currentUser!.uid)/\(imageId)")
        
        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if metadata == nil {
                print("Failed to upload the image")
                completion(false)
            }
            
            print("The image has been uploaded")
            completion(true)
        }
    }
    
    private func deleteImage(imageId: String) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageRef = storageRef
            .child("/users/\(Auth.auth().currentUser!.uid)/\(imageId)")
        
        imageRef.delete { error in
            if error != nil {
                print("Failed to delete the product image")
            } else {
                print("The product image has been deleted")
            }
        }
    }
}
