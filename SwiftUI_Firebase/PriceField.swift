//
//  PriceField.swift
//  SwiftUI_REST_Client
//
//  Created by user224607 on 7/23/22.
//

import SwiftUI
import Combine

struct PriceField: View {
    var title: String
    @Binding var value: Double
    @State private var enterendValue: String = ""
    var body: some View {
       TextField(title, text: $enterendValue)
            .onReceive(Just(enterendValue)){ typedValue in
                if let newValue = Double(typedValue){
                    self.value = newValue
                }
            }
            .onAppear(perform: {self.enterendValue = String(format: "%.02f", self.value)})
            .keyboardType(.decimalPad)
    }
}
