//
//  LoginView.swift
//  SwiftUI_Firebase
//
//  Created by user224607 on 8/6/22.
//

import Foundation
import SwiftUI
import FirebaseAuthUI

struct LoginView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return FUIAuth.defaultAuthUI()!.authViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
