//
//  DatabaseService.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 25/07/2022.
//

import Foundation
import Firebase

class DatabaseService {
    
    func setUserProfile(firstname: String, lastname: String, email: String, shareKey: String, completion: @escaping (Bool) -> Void) {
     
        // Ensure user is logged in
        guard AuthViewModel.isUserLoggedIn() != false else {
            // User is not logged in
            return
        }
        
        // Get a reference to Firestore
        let db = Firestore.firestore()
        
        // Set profile data
        let doc = db.collection("users").document(AuthViewModel.getLoggedInUserID())
        doc.setData(["firstname": firstname,
                     "lastname": lastname,
                     "email": email,
                     "shareKey": shareKey]) { error in
            
            if error == nil {
                // Save successful
                completion(true)
            } else {
                // Failed to save
                completion(false)
            }
            
        }
        
    }
    
    /// This method gets all holidays from the database created by the signed in user
//    func getAllHolidays(completion: @escaping ([Holiday]) -> Void ) {
//     
//        // Get reference to database
//        let db = Firestore.firestore()
//        
//        // Perform a query against the holiday collection for any holidays which were created by the user
//        let holidaysQuery = db.collection("holidays")
//            .whereField("createdBy", isEqualTo: AuthViewModel.getLoggedInUserID())
//
//        holidaysQuery.getDocuments { snapshot, error in
//            
//            if snapshot != nil && error == nil {
//                
//                var holidays = [Holiday]()
//                
//                // Loop through and return all holidays
//                for doc in snapshot!.documents {
//                    
//                    // Parse the data in holiday structure
//                    let holiday = try? doc.data(as: Holiday.self)
//                    
//                    if let holiday = holiday {
//                        holidays.append(holiday)
//                    }
//                }
//                
//                completion(holidays)
//                
//            } else {
//                print("error retrieving data")
//            }
//            
//        }
//        
//    }
//    
//    func createHoliday(holiday: Holiday, completion: @escaping (String) -> Void) {
//     
//        // Get reference to database
//        let db = Firestore.firestore()
//        
//        // Create a document
//        let doc = db.collection("holidays").document()
//        
//        // Set the data for the documents
//        try? doc.setData(from: holiday, completion: { error in
//            
//            // Communicate the document id
//            completion(doc.documentID)
//            
//        })
//
//        
//    }
    
}
