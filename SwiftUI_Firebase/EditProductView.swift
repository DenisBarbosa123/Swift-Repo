//
//  EditProductView.swift
//  SwiftUI_Firebase
//
//  Created by user224607 on 8/6/22.
//

import SwiftUI

struct EditProductView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false
    @State private var editProductViewModel = EditProductViewModel()
    
    init(product: Product){
        self.editProductViewModel.setProduct(product: product)
    }
    
    private func updateProduct(){
        showAlert = false
        if editProductViewModel.updateProduct() {
            self.presentationMode.wrappedValue.dismiss()
        } else {
            showAlert = true
        }
    }
    
    var body: some View {
        Form{
            Section() {
                TextField("Enter the name", text:self.$editProductViewModel.name)
                TextField("Enter the description", text:self.$editProductViewModel.description)
                TextField("Enter the code", text:self.$editProductViewModel.code)
                PriceField(title: "Enter the price", value: self.$editProductViewModel.price)
            }
        }
            .navigationBarTitle("Edit product", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: updateProduct){
                Text("Save").foregroundColor(.blue)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("The product could not be updated"), dismissButton: .default(Text("Dismiss")))
            }
        }
    }

struct EditProductView_Previews: PreviewProvider {
    static var previews: some View {
        EditProductView(product: Product(userId: "1", name: "nome", description: "descrição", code: "código", price: 1.0))
    }
}
