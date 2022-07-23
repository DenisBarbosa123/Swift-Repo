//
//  ContentView.swift
//  SwiftUI_Hello_World
//
//  Created by user224607 on 7/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var product = Product()
    @State private var isValidCode = true
    @State private var isProductSaved = false
    
    private func saveProduct() {
        isValidCode = product.code.count >= 5
        isProductSaved = isValidCode
    }
    
    var body: some View {
        Form{
            ProductCreationView(product: $product,
                                isValidCode: isValidCode)
            
            Section{
                Button(action: saveProduct){
                    Text("Save")
                }
            }
            
            if(self.isProductSaved)
            {
                ProductSavedView(product: self.product)
            }
        }
    }
}

struct ProductCreationView: View {
    //Binding serve para conectar os dois objetos, quando muda valor de um atributo, muda valor do outro, nesse caso iremos ler e escrever entao eh necessario uso do binding
    @Binding var product: Product
    // esse cara nao precisa de binding pois soh iremos ler
    var isValidCode: Bool
    var body: some View{
        Section(header: Text("Product")) {
            VStack(alignment: .leading){
                Text("Name: ")
                TextField("Enter the name", text: $product.name)
            }
            
            VStack(alignment: .leading){
                Text("Description: ")
                TextField("Enter the description", text: $product.description)
            }
            
            VStack(alignment: .leading){
                Text("Code: ")
                HStack{
                    TextField("Enter the code", text: $product.code)
                    if (self.isValidCode == false){
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct ProductSavedView: View{
    var product: Product
    var body: some View {
        Section(header: Text("Product saved")){
            Text("Name: \(product.name)")
            Text("Description: \(product.description)")
            Text("Code: \(product.code)")
            Text("Price: \(product.price)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
