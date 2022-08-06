import SwiftUI
import Firebase
@main
struct SwiftUI_FirebaseApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
