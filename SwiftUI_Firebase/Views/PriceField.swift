import SwiftUI
import Combine

struct PriceField : View {
    @State private var enteredValue: String = ""
    @Binding var value: Double
 
    var body: some View {
        TextField("Enter the price", text: $enteredValue)
            .onReceive(Just(enteredValue)) { typedValue in
                if let newValue = Double(typedValue) {
                    self.value = newValue
                }
        }.onAppear(perform:{self.enteredValue = String(format: "%.02f", self.value)})
            .keyboardType(.decimalPad)
    }
}

struct PriceField_Previews: PreviewProvider {
    static var previews: some View {
        PriceField(value: .constant(0))
    }
}
