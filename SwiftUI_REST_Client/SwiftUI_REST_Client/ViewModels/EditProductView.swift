//
//  EditProductView.swift
//  SwiftUI_REST_Client
//
//  Created by user224607 on 7/23/22.
//

import SwiftUI

struct EditProductView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var product: Product
    var completion: (Product) -> Void
    
    @State private var showAlert = false
    @State private var editProductViewModel = EditProductViewModel()
    
    init(product: Product, completion: @escaping (Product) -> Void){
        self.product = product
        self.completion = completion
        self.editProductViewModel.setProduct(product: product)
    }
    
    private func updateProduct(){
        showAlert = false
        editProductViewModel.updateProduct(){
            product in
            if let p = product {
                completion(p)
                self.presentationMode.wrappedValue.dismiss()
            }else{
                showAlert = false
            }
        }
    }
    
    var body: some View {
        Form{
            Section(){
                TextField("Enter the name", text: self.$editProductViewModel.name)
                TextField("Enter the description", text: self.$editProductViewModel.description)
                TextField("Enter the code", text: self.$editProductViewModel.code)
                PriceField(title: "Enter the price", value: self.$editProductViewModel.price)
            }
            .navigationBarTitle("Edit Product", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: updateProduct){
                Text("Save").foregroundColor(.blue)
                
            })
            .alert(isPresented: $showAlert){
                Alert(title: Text("Error"), message: Text("The product could not be updated"), dismissButton: .default(Text("Dismiss")))
            }
        }
    }
}

struct EditProductView_Previews: PreviewProvider {
    static var previews: some View {
        EditProductView(product: Product(id: 0, name: "name", description: "desc", code: "code", price: 10.0)){
            product in
        }
    }
}
