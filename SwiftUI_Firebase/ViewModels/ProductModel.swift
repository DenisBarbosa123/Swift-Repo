import Foundation
import SwiftUI

class ProductModel {
    var product: Product
    var image = UIImageView(image: UIImage(systemName: "photo"))
    
    init(product: Product) {
        self.product = product
    }
    
    var id: String? {
        return self.product.id
    }

    var name: String {
        return self.product.name
    }

    var code: String {
        return self.product.code
    }

    var price: Double {
        return self.product.price
    }
}
