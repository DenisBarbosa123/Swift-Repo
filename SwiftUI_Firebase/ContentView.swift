//
//  ContentView.swift
//  SwiftUI_Firebase
//
//  Created by Paulo Siecola on 21/05/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject private var authenticationViewModel = AuthenticationViewModel()
    @ObservedObject private var productListViewModel = ProductListViewModel()
    @State private var showModal = false
    @State private var showAlert = false
    
    private func showNewProductView() {
        self.showModal = true
    }
    
    private func deleteProduct(indexSet: IndexSet) {
        let productToBeDeleted = self.productListViewModel.products[indexSet.first!]
        productListViewModel.deleteProduct(product: productToBeDeleted) { result in
            showAlert = !result
        }
    }

    private func signOut(){
        productListViewModel.clearProducts()
        authenticationViewModel.signOut()
    }
    
    var body: some View {
        if authenticationViewModel.isLogged {
            NavigationView{
                List{
                    ForEach(self.productListViewModel.products, id: \.id){ product in
                        NavigationLink(destination: EditProductView(product: product)){
                            HStack{
                                Text(product.name)
                                Spacer()
                                Text(product.code)
                                Spacer()
                                Text(String(format: "$ %.2f", product.price))
                            }
                        }
                    }
                    .onDelete(perform: self.deleteProduct)
                }
                .navigationBarTitle("Products", displayMode: .inline)
                .navigationBarItems(leading: Button(action: signOut) {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(Color.blue)
                }, trailing: Button(action: showNewProductView) {
                    Image(systemName: "plus")
                        .foregroundColor(Color.blue)
                })
                .sheet(isPresented: $showModal) {
                    AddNewProductView(isPresented: self.$showModal)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"),
                message: Text("The product couldn't be deleted"), dismissButton: .default(Text("Dismiss")))
                }
            }.onAppear(){
                productListViewModel.fetchProducts()
            }
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
