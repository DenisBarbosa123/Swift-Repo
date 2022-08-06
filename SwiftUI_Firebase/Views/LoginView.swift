import SwiftUI
import FirebaseAuthUI

struct LoginView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        return FUIAuth.defaultAuthUI()!.authViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController,
                                context: Context) {

    }
}
