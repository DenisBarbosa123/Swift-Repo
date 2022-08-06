import Foundation
import SwiftUI
import PhotosUI

struct ProductPhotoPicker: UIViewControllerRepresentable {
      
    @Binding var showPhotoPicker: Bool
    var completion: (UIImage) -> Void
        
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType,
                                context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        
        return controller
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: ProductPhotoPicker
        
        init(_ parent: ProductPhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController,
                    didFinishPicking results: [PHPickerResult]) {
            if results.count > 0 {
                if (results[0].itemProvider.canLoadObject(ofClass: UIImage.self)) {
                    results[0].itemProvider.loadObject(ofClass: UIImage.self) {
                        image, error in
                        
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.parent.completion (image as! UIImage)
                        }
                    }
                }
            }

            parent.showPhotoPicker = false
        }
    }
}
