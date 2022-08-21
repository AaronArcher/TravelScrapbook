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
    @State private var password = ""
    @State private var confirmPassword = ""
    
    
    @FocusState private var firstNameFocused: Bool
    @FocusState private var lastNameFocused: Bool
    @FocusState private var emailFocused: Bool
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
                        TextField("First Name", text: $firstName)
                            .padding(.vertical, 5)
                            .focused($firstNameFocused)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(
                                    TextBackground(isTextfield: true, isFocused: firstNameFocused)
                            )
                            .padding(.vertical, 10)
                    
                    // Last Name
                        TextField("Last Name", text: $lastName)
                            .padding(.vertical, 5)
                            .focused($lastNameFocused)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(
                                    TextBackground(isTextfield: true, isFocused: lastNameFocused)
                            )
                            .padding(.vertical, 10)
                    
                    // Email
                        TextField("Email", text: $email)
                            .padding(.vertical, 5)
                            .focused($emailFocused)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(
                                    TextBackground(isTextfield: true, isFocused: emailFocused)
                            )
                            .padding(.vertical, 10)
                    
                    
                    // Password
                        SecureField("Password", text: $password)
                            .padding(.vertical, 5)
                            .focused($passwordFocused)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(
                                    TextBackground(isTextfield: true, isFocused: passwordFocused)
                            )
                            .padding(.vertical, 10)
                    
                    // Confirm Password
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding(.vertical, 5)
                            .focused($confirmPasswordFocused)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(
                                    TextBackground(isTextfield: true, isFocused: confirmPasswordFocused)
                            )
                            .padding(.vertical, 10)
                    
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
        
        firstNameFocused = false
        lastNameFocused = false
        emailFocused = false
        passwordFocused = false
        confirmPasswordFocused = false
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
            
                if error == nil {
                        
                    DatabaseService().setUserProfile(firstname: firstName, lastname: lastName, email: email) { isSuccess in
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
