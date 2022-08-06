import Foundation
import FirebaseAuthUI
import FirebaseGoogleAuthUI
class AuthenticationViewModel: NSObject, ObservableObject, FUIAuthDelegate {
    @Published var isLogged = false
    
    override init(){
        super.init()
        
        let authUI = FUIAuth.defaultAuthUI()!
        
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(authUI: authUI)
        ]
        
        authUI.providers = providers
        authUI.delegate = self
        
        if Auth.auth().currentUser != nil {
            isLogged = true
        }else {
            isLogged = false
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        print("Signed is as \(String(describing: Auth.auth().currentUser?.displayName))")
        if let _ = error {
            isLogged = false
        } else {
            isLogged = true
        }
    }
    
    func signOut(){
        try? Auth.auth().signOut()
        isLogged = false
    }
}
