//
//  AuthViewModel.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 26/07/2022.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    
    
    static func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    static func getLoggedInUserID() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static func logOut() {
        try? Auth.auth().signOut()
    }
    
}
