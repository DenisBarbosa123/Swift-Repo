//
//  AddNewProductView.swift
//  SwiftUI_REST_Client
//
//  Created by user224607 on 7/23/22.
//

import SwiftUI

struct AddNewProductView: View {
    @Binding var isPresented: Bool
    @State private var addNewProductViewModel = AddNewProductViewModel()
    @State private var showAlert = false
    var completion: (Product) -> Void
    
    private func dismiss(){
        self.isPresented = false
    }
    
    private func saveProduct(){
        self.showAlert = false
        self.addNewProductViewModel.saveNewProduct{
            product in
            if let p = product {
                completion(p)
                self.isPresented = false
            }else {
                self.showAlert = true
            }
        }
    }
    var body: some View {
        NavigationView{
            Form{
                Section(){
                    TextField("Enter the name", text: self.$addNewProductViewModel.name)
                    TextField("Enter the description", text: self.$addNewProductViewModel.description)
                    TextField("Enter the code", text: self.$addNewProductViewModel.code)
                    PriceField(title: "Enter the price", value: self.$addNewProductViewModel.price)
                }
            }
            .navigationBarTitle("New Product", displayMode: .inline)
            .navigationBarItems(leading: Button(action: dismiss){
                Text("Cancel").foregroundColor(.red)
            }, trailing: Button(action: saveProduct){
                Text("Add").foregroundColor(.blue)
            })
        }
        .alert(isPresented: $showAlert){
            Alert(title: Text("Error"), message: Text("The product could not be created"), dismissButton: .default(Text("Dismiss")))
        }
    }
}

struct AddNewProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProductView(isPresented: .constant(false)){ product in
            
        }
    }
}
