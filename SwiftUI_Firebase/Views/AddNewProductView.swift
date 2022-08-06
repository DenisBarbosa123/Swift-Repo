import SwiftUI
import Firebase

struct AddNewProductView: View {
    @Binding var isPresented: Bool
    @State private var addNewProductViewModel = AddNewProductViewModel()
    @State private var showAlert = false
    @State private var isSaving = false
    @State private var image = UIImage(systemName: "photo")!
    @State private var showPhotoPicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Enter the name",
                              text:self.$addNewProductViewModel.name)

                    TextField("Enter the description",
                              text:self.$addNewProductViewModel.description)

                    TextField("Enter the code",
                              text:self.$addNewProductViewModel.code)
                    
                    PriceField(value: self.$addNewProductViewModel.price)
                }
                Section() {
                    Button("Select the photo") {
                        showPhotoPicker.toggle()
                    }
                }

                Section() {
                    Image.init(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            .navigationBarTitle("New product", displayMode: .inline)
            .navigationBarItems(leading: Button(action: dismiss) {
                Text("Cancel").foregroundColor(.red)
            }, trailing: Button(action: saveProduct) {
                Text("Add").foregroundColor(.blue)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text("The product couldn't be saved"),
                      dismissButton: .default(Text("Dismiss")))
            }
            .sheet(isPresented: $showPhotoPicker) {
                ProductPhotoPicker(showPhotoPicker: self.$showPhotoPicker) { image in
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
            .alert(isPresented: $isSaving) {
                Alert(title: Text("New product"),
                      message: Text("Saving product..."))
            }
            .onAppear() {
                Analytics.logEvent("new_item", parameters: nil)
            }
        }
    }
    
    private func dismiss() {
        self.isPresented = false
    }
    
    private func saveProduct() {
        self.showAlert = false
        self.isSaving = true
        self.addNewProductViewModel
            .saveNewProduct(imageData: image.jpegData(compressionQuality: 0.0)) {
                success in
                
            self.isSaving = false
            if success {
                self.isPresented = false
            } else {
                self.showAlert = true
            }
        }
    }    
}

struct AddNewProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProductView(isPresented: .constant(false))
    }
}
