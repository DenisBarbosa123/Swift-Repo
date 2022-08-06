import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

class ProductListViewModel: ObservableObject {
    @Published var products = [ProductModel]()
    
    private let db = Firestore.firestore()

    func fetchProducts() {
        db.collection(Product.COLLECTION).whereField(Product.USER_ID,
             isEqualTo: Auth.auth().currentUser!.uid).order(by: Product.NAME)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.products = documents.compactMap {
                    queryDocumentSnapshot -> Product? in
                    return try? queryDocumentSnapshot.data(as: Product.self)
                }.map(ProductModel.init)
                
                self.loadImages()
            }
    }
    
    func clearProducts() {
        products = [ProductModel]()
    }
    
    func deleteProduct(product: Product, completion: @escaping (Bool) -> Void) {
        if let imageId = product.imageId {
            self.deleteImage(imageId: imageId)
        }
        
        db.collection(Product.COLLECTION).document(product.id!).delete() { error in
            if let error = error {
                print("Error while removing the product: \(error)")
                completion(false)
            } else {
                print("Product successfully removed!")
                completion(true)
            }
        }
    }
    
    private func loadImages() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let userid = Auth.auth().currentUser!.uid

        for product in products {
            if let imageId = product.product.imageId {
                
                let imageRef = storageRef
                    .child("/users/\(userid)/\(imageId)")
                
                print("Loading imageId: \(imageId)")
                product.image.sd_setImage(with: imageRef,
                      placeholderImage: UIImage(systemName: "photo")) {
                    (image, error, cacheType, storageRef) in
                    
                    if let error = error {
                        print("Error loading image: \(error)")
                    } else {
                        print("Image loaded")
                        DispatchQueue.main.async {
                            product.image = UIImageView(image: image)
                            self.objectWillChange.send()
                        }
                    }
                }
            }
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
