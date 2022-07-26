//
//  LoginView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 26/07/2022.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
        
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?
    
    @Binding var showOnboarding: Bool
    
    var body: some View {
        
        Form {
            Section {
                
                TextField("Email", text: $email)
                
                SecureField("Password", text: $password)
//                SecureField("Confirm Password", text: $confirmPassword)
                
            }
            if errorMessage != nil {
                
                Section {
                    Text(errorMessage!)
                }
            }
            
            Button {
                
                signIn()
                
            } label: {
                Text("Sign up")
            }
            
            
        }
        
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error == nil {
                // Dismiss
                showOnboarding = !AuthViewModel.isUserLoggedIn()
                
            } else {
                // show error message
                errorMessage = error!.localizedDescription
            }
            
        }
    }
    
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
