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
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    // First Name
                    VStack(spacing: 0) {
                        TextField("First Name", text: $firstName)
                            .padding(.vertical, 5)
                            .focused($firstNameFocused)
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.clear)
                                .cornerRadius(5)
                            
                            Rectangle()
                                .frame(height: 2)
                                .frame(maxWidth: firstNameFocused || !firstName.isEmpty ? .infinity : 0)
                                .animation(.easeInOut, value: firstNameFocused)
                                .foregroundColor(Color("Green1"))
                                .cornerRadius(5)
                            
                        }
                        .padding(.trailing)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(.white)
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                            .frame(height: 50)
                    )
                    .padding(.top, 10)
                    
                    // Last Name
                    VStack(spacing: 0) {
                        TextField("Last Name", text: $lastName)
                            .padding(.vertical, 5)
                            .focused($lastNameFocused)
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.clear)
                                .cornerRadius(5)
                            
                            Rectangle()
                                .frame(height: 2)
                                .frame(maxWidth: lastNameFocused || !lastName.isEmpty ? .infinity : 0)
                                .animation(.easeInOut, value: lastNameFocused)
                                .foregroundColor(Color("Green1"))
                                .cornerRadius(5)
                            
                        }
                        .padding(.trailing)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(.white)
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                            .frame(height: 50)
                    )
                    
                    // Email
                    VStack(spacing: 0) {
                        TextField("Email", text: $email)
                            .padding(.vertical, 5)
                            .focused($emailFocused)
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.clear)
                                .cornerRadius(5)
                            
                            Rectangle()
                                .frame(height: 2)
                                .frame(maxWidth: emailFocused || !email.isEmpty ? .infinity : 0)
                                .animation(.easeInOut, value: emailFocused)
                                .foregroundColor(Color("Green1"))
                                .cornerRadius(5)
                            
                        }
                        .padding(.trailing)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(.white)
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                            .frame(height: 50)
                    )
                    
                    // Share Key
                    VStack(spacing: 0) {
                        TextField("Create a share key*", text: $shareKey)
                            .padding(.vertical, 5)
                            .focused($shareKeyFocused)
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.clear)
                                .cornerRadius(5)
                            
                            Rectangle()
                                .frame(height: 2)
                                .frame(maxWidth: shareKeyFocused || !shareKey.isEmpty ? .infinity : 0)
                                .animation(.easeInOut, value: shareKeyFocused)
                                .foregroundColor(Color("Green1"))
                                .cornerRadius(5)
                            
                        }
                        .padding(.trailing)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(.white)
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                            .frame(height: 50)
                    )
                    
                    Text("* This will be used to share your holiday with friends!")
                        .font(.caption)
                        .padding(.leading)
                        .padding(.bottom, 10)
                    
                    // Password
                    VStack(spacing: 0) {
                        SecureField("Password", text: $password)
                            .padding(.vertical, 5)
                            .focused($passwordFocused)
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.clear)
                                .cornerRadius(5)
                            
                            Rectangle()
                                .frame(height: 2)
                                .frame(maxWidth: passwordFocused || !password.isEmpty ? .infinity : 0)
                                .animation(.easeInOut, value: passwordFocused)
                                .foregroundColor(Color("Green1"))
                                .cornerRadius(5)
                            
                        }
                        .padding(.trailing)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(.white)
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                            .frame(height: 50)
                    )
                    
                    // Confirm Password
                    VStack(spacing: 0) {
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding(.vertical, 5)
                            .focused($confirmPasswordFocused)
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.clear)
                                .cornerRadius(5)
                            
                            Rectangle()
                                .frame(height: 2)
                                .frame(maxWidth: confirmPasswordFocused || !confirmPassword.isEmpty ? .infinity : 0)
                                .animation(.easeInOut, value: confirmPasswordFocused)
                                .foregroundColor(Color("Green1"))
                                .cornerRadius(5)
                            
                        }
                        .padding(.trailing)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(.white)
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                            .frame(height: 50)
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
                    
                    Spacer()
                    
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
