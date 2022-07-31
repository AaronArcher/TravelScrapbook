//
//  CreateAccountView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 26/07/2022.
//

import SwiftUI
import FirebaseAuth

struct CreateAccountView: View {
    
    @Binding var showLogin: Bool
    @Binding var showCreateAccount: Bool
//    @Binding var showOnboarding: Bool
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var shareKey = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    
    @FocusState private var firstNameFocused: Bool
    @FocusState private var lastNameFocused: Bool
    @FocusState private var emailFocused: Bool
    @FocusState private var shareKeyFocused: Bool
    @FocusState private var passwordFocused: Bool
    @FocusState private var confirmPasswordFocused: Bool

    
    @State private var errorMessage: String?

    var body: some View {
        
        ScrollView {

            VStack(alignment: .leading) {
            
            // Header
            Group {
                Text("Lets get started!")
                    .font(.largeTitle)
                    .padding(.top, 40)
                
                Text("Create an account below")
                    .font(.title)
                    .foregroundColor(Color("Green3"))
                    .padding(.bottom, 20)
                    
            }
            .padding(.horizontal)
            
            if errorMessage != nil {
                Text(errorMessage!)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.horizontal)

            }
            
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    // First Name
                    VStack(spacing: 0) {
                        TextField("First Name", text: $firstName)
                            .padding(.vertical, 5)
                            .focused($firstNameFocused)
                        
                    }
                    .padding()
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                .frame(height: 50)
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .trim(from: 0, to: firstNameFocused ? 1 : 0)
                                .stroke(Color("Green2"), lineWidth: 1)
                                .frame(height: 50)
                                .animation(.easeInOut(duration: 0.8), value: firstNameFocused)
                        }

                    )
                    .padding(.top, 10)
                    
                    // Last Name
                    VStack(spacing: 0) {
                        TextField("Last Name", text: $lastName)
                            .padding(.vertical, 5)
                            .focused($lastNameFocused)
                        
                    }
                    .padding()
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                .frame(height: 50)
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .trim(from: 0, to: lastNameFocused ? 1 : 0)
                                .stroke(Color("Green2"), lineWidth: 1)
                                .frame(height: 50)
                                .animation(.easeInOut(duration: 0.8), value: lastNameFocused)
                        }

                    )
                    
                    // Email
                    VStack(spacing: 0) {
                        TextField("Email", text: $email)
                            .padding(.vertical, 5)
                            .focused($emailFocused)
                        
                    }
                    .padding()
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                .frame(height: 50)
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .trim(from: 0, to: emailFocused ? 1 : 0)
                                .stroke(Color("Green2"), lineWidth: 1)
                                .frame(height: 50)
                                .animation(.easeInOut(duration: 0.8), value: emailFocused)
                        }

                    )
                    
                    
                    // Password
                    VStack(spacing: 0) {
                        SecureField("Password", text: $password)
                            .padding(.vertical, 5)
                            .focused($passwordFocused)
                        
                    }
                    .padding()
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                .frame(height: 50)
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .trim(from: 0, to: passwordFocused ? 1 : 0)
                                .stroke(Color("Green2"), lineWidth: 1)
                                .frame(height: 50)
                                .animation(.easeInOut(duration: 0.8), value: passwordFocused)
                        }

                    )
                    
                    // Confirm Password
                    VStack(spacing: 0) {
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding(.vertical, 5)
                            .focused($confirmPasswordFocused)
                        
                    }
                    .padding()
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                .frame(height: 50)
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .trim(from: 0, to: confirmPasswordFocused ? 1 : 0)
                                .stroke(Color("Green2"), lineWidth: 1)
                                .frame(height: 50)
                                .animation(.easeInOut(duration: 0.8), value: confirmPasswordFocused)

                                
                        }

                    )
                    
                    // Create Account
                    Button {
                        
                        createAccount()
                    
                    } label: {
                        
                            Text("Create Account")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .foregroundColor(Color("Green1"))
                                    .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                    .frame(height: 50)
                            )
                    }
                    .padding(.vertical)
                    
                    HStack {
                        
                        Spacer()
                        
                        Text("Already have an account?")
                            .font(.caption)
                        
                        Button {
                            
                            showCreateAccount = false
                            
                        } label: {
                            Text("Login here!")
                                .foregroundColor(Color("Green3"))
                                .font(.caption)
                        }
                    
                    Spacer()
                    
                }
                    // gone over 20 child views so used a group
                    Group {
                    
                        Color.clear
                        .frame(height: 60)
                    
                        Spacer()
                    
                    }
                }
                .padding(.horizontal)
                
            }
        
    }
        .foregroundColor(Color("Green1"))
        
        
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
            
                if error == nil {
                        
                    DatabaseService().setUserProfile(firstname: firstName, lastname: lastName, email: email, shareKey: shareKey) { isSuccess in
                        if isSuccess == true {
                            // dismiss
                            showLogin = !AuthViewModel.isUserLoggedIn()
                        } else {
                            // Failed to save data to database
                            errorMessage = "Failed to save user, check internet connection"
                        }
                    }
                
                } else {
                    errorMessage = error?.localizedDescription
                }

                
            }
            
        }
    }
    
}

//struct CreateAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateAccountView(showLogin: .constant(true))
//    }
//}
