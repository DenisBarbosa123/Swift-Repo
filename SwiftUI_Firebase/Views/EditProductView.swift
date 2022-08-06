import SwiftUI
import Firebase
import FirebaseStorageUI

struct EditProductView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>

    var product: Product

    @State private var showAlert = false
    @State private var editProductViewModel = EditProductViewModel()
    @State private var isSaving = false
    @State private var image = UIImageView(image: UIImage(systemName: "photo"))
    @State private var showPhotoPicker = false
    @State private var newPhoto = false
    
    init(product: Product) {
        self.product = product
        self.editProductViewModel.setProduct(product: product)
        
        Analytics.logEvent(FirebaseAnalytics.AnalyticsEventSelectItem,
                   parameters: [AnalyticsParameterItemID: product.code
        ])
    }
    
    var body: some View {
        Form {
            Section() {
                TextField("Enter the name",
                          text:self.$editProductViewModel.name)

                TextField("Enter the description",
                          text:self.$editProductViewModel.description)

                TextField("Enter the code",
                          text:self.$editProductViewModel.code)

                PriceField(value: $editProductViewModel.price)
            }
            Section() {
                Button("Change the photo") {
                    showPhotoPicker.toggle()
                }
            }
            Section() {
                Image(uiImage: image.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onAppear() {
                        if let imageId = self.product.imageId {
                            let storage = Storage.storage()
                            let storageRef = storage.reference()
                            
                            let imageRef = storageRef
                                .child("/users/\(Auth.auth().currentUser!.uid)/\(imageId)")
                            
                            self.image.sd_setImage(with: imageRef,
                                   placeholderImage: UIImage(systemName: "photo")) {
                                (image, error, cacheType, storageRef) in
                                
                                if let error = error {
                                    print("Error loading image: \(error)")
                                }
                            }
                        }
                    }
            }
            
            .navigationBarTitle("Edit product", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: updateProduct) {
                Text("Save").foregroundColor(.blue)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text("The product couldn't be updated"),
                      dismissButton: .default(Text("Dismiss")))
            }
            .alert(isPresented: $isSaving) {
                Alert(title: Text("Edit product"),
                      message: Text("Saving product..."))
            }
            .sheet(isPresented: $showPhotoPicker) {
                ProductPhotoPicker(showPhotoPicker: self.$showPhotoPicker) { image in
                    self.newPhoto = true
                    DispatchQueue.main.async {
                        self.image = UIImageView(image: image)
                    }
                }
            }
        }
    }
    
    private func updateProduct() {
        showAlert = false
        self.isSaving = true
        editProductViewModel.updateProduct(newPhoto: self.newPhoto,
               imageData: image.image!.jpegData(compressionQuality: 0.0)) {
            success in
            
            self.isSaving = false
            if success {
                self.presentationMode.wrappedValue.dismiss()
            } else {
                showAlert = true
            }
        }
    }
}

struct EditProductView_Previews: PreviewProvider {
    static var previews: some View {
        EditProductView(product: Product(userId: "1", name: "Product1",
                 description: "desc", code: "cod", price: 0.0))
    }
}
