//
//  LoginView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 26/07/2022.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @Binding var showLogin: Bool
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?
    
    @FocusState private var emailFocused: Bool
    @FocusState private var passwordFocused: Bool
    
    @State private var showCreateAccount = false
    
    
    var body: some View {
        
        if !showCreateAccount {
            
            VStack(alignment: .leading) {
                
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .padding(.top, 40)
                
                Text("Login Below")
                    .font(.title)
                    .foregroundColor(Color("Green3"))
                    .padding(.bottom, 30)
                
                if errorMessage != nil {
                    Text(errorMessage!)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                ScrollView {
                
                    VStack(spacing: 0) {
                   
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
                    
                    
                    Button {
                        
                        login()
                    
                    } label: {
                        
                            Text("Login")
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
                        
                        Text("Don't have an account?")
                            .font(.caption)
                        
                        Button {
                            
                            showCreateAccount = true
                            
                        } label: {
                            Text("Sign up here!")
                                .foregroundColor(Color("Green3"))
                                .font(.caption)
                        }

                        
                        Spacer()
                        
                    }
                    
                }
                
                }
                
                
                
                Spacer()
                
            }
            .foregroundColor(Color("Green1"))
            .padding(.horizontal)
           
            
        } else {
         
            CreateAccountView(showLogin: $showLogin, showCreateAccount: $showCreateAccount)
            
        }
        
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error == nil {
                // Dismiss
                showLogin = !AuthViewModel.isUserLoggedIn()
                
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
