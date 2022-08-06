import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorageUI

class AddNewProductViewModel {

    var name: String = ""
    var description: String = ""
    var code: String = ""
    var price: Double = 0.0

    private let db = Firestore.firestore()

    func saveNewProduct(imageData: Data?,
                        completion: @escaping (Bool) -> Void) {
        
        if let imageData = imageData {
            let imageId = UUID().uuidString

            saveProductImage(imageData: imageData, imageId: imageId) {
                success in
                
                if success {
                    self.saveProduct(imageId: imageId) { result in
                        completion(result)
                    }
                } else {
                    completion(false)
                }
            }
        } else {
            saveProduct(imageId: nil) { result in
                completion(result)
            }
        }
    }

    private func saveProduct(imageId: String?,
                             completion: @escaping (Bool) -> Void) {
        
        let product = Product(userId: Auth.auth().currentUser!.uid,
                              name: self.name,
                              description: self.description,
                              code: self.code,
                              price: self.price,
                              imageId: imageId)
        
        let newProductRef = db.collection(Product.COLLECTION).document()
        
        do {
            try newProductRef.setData(from: product)
            print("Product saved - ID: \(newProductRef.documentID)")
            completion(true)
        } catch let error {
            print("Error while saving new product: \(error)")
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
}
