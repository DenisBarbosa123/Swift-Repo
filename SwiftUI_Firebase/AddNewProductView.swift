//
//  AddNewProductView.swift
//  SwiftUI_Firebase
//
//  Created by user224607 on 8/6/22.
//

import SwiftUI

struct AddNewProductView: View {
    @Binding var isPresented: Bool
    @State private var addNewProductViewModel = AddNewProductViewModel()
    @State private var showAlert = false
    
    private func dismiss(){
        self.isPresented = false
    }
    
    private func saveProduct(){
        self.showAlert = false
        if self.addNewProductViewModel.saveNewProduct() {
            self.isPresented = false
        } else {
            showAlert = true
        }
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section() {
                    TextField("Enter the name", text:self.$addNewProductViewModel.name)
                    TextField("Enter the description", text:self.$addNewProductViewModel.description)
                    TextField("Enter the code", text:self.$addNewProductViewModel.code)
                    PriceField(title: "Enter the price", value: self.$addNewProductViewModel.price)
                }
                
            }
                .navigationBarTitle("New Product", displayMode: .inline)
                .navigationBarItems(leading: Button(action: dismiss){
                    Text("Cancel").foregroundColor(.red)
                }, trailing: Button(action: saveProduct){
                    Text("Save").foregroundColor(.blue)
                })
                .alert(isPresented: $showAlert){
                    Alert(title: Text("Error"), message: Text("The product could not be saved"), dismissButton: .default(Text("Dismiss")))
                }
        }
    }
}
