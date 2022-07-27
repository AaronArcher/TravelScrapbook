//
//  DatabaseService.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 25/07/2022.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class DatabaseService {
    
    var holidayListener = [ListenerRegistration]()

    
    func setUserProfile(firstname: String, lastname: String, email: String, shareKey: String, completion: @escaping (Bool) -> Void) {
     
//        // Ensure user is logged in
//        guard AuthViewModel.isUserLoggedIn() != false else {
//            // User is not logged in
//            return
//        }
        
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
    func getAllHolidays(completion: @escaping ([Holiday]) -> Void ) {
     
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Perform a query against the holiday collection for any holidays where the createdBy field is the logged in user ID
        let holidaysQuery = db.collection("holidays")
            .whereField("createdBy", isEqualTo: AuthViewModel.getLoggedInUserID())
//            .order(by: "date") // This is creating issues with the listener and not pushing the same data between devices
        
        let listener = holidaysQuery.addSnapshotListener { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var holidays = [Holiday]()
                
                for doc in snapshot!.documents {
                    
                    let data = doc.data()
                    let id = doc.documentID
                    let title = data["title"] as? String ?? ""
//                    let createdBy = data["createdBy"] as? String ?? ""
                    let date = data["date"] as? Date ?? Date()
                    let city = data["city"] as? String ?? ""
                    let country = data["country"] as? String ?? ""
                    let locationID = data["locationID"] as? String ?? ""
                    let latitude = data["latitude"] as? Double ?? 0
                    let longitude = data["longitude"] as? Double ?? 0
                    let mainImage = data["mainImage"] as? String ?? ""

                    print(mainImage)
                    
                    holidays.append(Holiday(id: id,
//                                            createdBy: createdBy,
                                            title: title,
                                            date: date,
                                            location: Location(id: locationID,
                                                               city: city,
                                                               country: country,
                                                               latitude: latitude,
                                                               longitude: longitude),
                                            mainImage: mainImage))
                    
                
                }
                
                completion(holidays)
                
            } else {
                // there was an error
                print("error retrieving holidays")
            }
        }
        // Keep track of the listener so we can close it later
        holidayListener.append(listener)
       
    }
    
    func createHoliday(title: String, date: Date, locationID: String, city : String, country: String, latitude: Double, longitude: Double, mainImage: UIImage?, allImages: [UIImage]?, completion: @escaping (Bool) -> Void) {
     
        // Get reference to database
        let db = Firestore.firestore()
        
        // Create a document
        let doc = db.collection("holidays").document()
        doc.setData(["createdBy" : AuthViewModel.getLoggedInUserID(),
                     "title" : title,
                     "date" : date,
                     "locationID" : locationID,
                     "city" : city,
                     "country" : country,
                     "latitude" : latitude,
                     "longitude" : longitude,
                    ])
        
        // Check if a main image is passed through
        if let mainImage = mainImage {
            
            // Create storage reference
            let storageRef = Storage.storage().reference()
            
            // Turn image into data
            let imageData = mainImage.jpegData(compressionQuality: 0.05)
            
            // Check we were able to convert it into data
            guard imageData != nil else { return }
            
            // specify the filePath and name
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            let uploadTask = fileRef.putData(imageData!, metadata: nil) { meta, error in
                
                if error == nil && meta != nil {
                    // Get full URL to image
                    fileRef.downloadURL { url, error in
                        
                        if url != nil && error == nil {
                            
                            doc.setData(["mainImage" : url!.absoluteString], merge: true) { error in
                                if error == nil {
                                    // Success, notify caller
                                    completion(true)
                                }
                            }
                            
                        } else {
                            // Wasn't successful grabbing the url
                            completion(false)
                        }
                        
                    }
                    
                } else {
                    // Upload wasn't successful, notify caller
                    completion(false)
                }
                
            }
            
        } else {
            // No image set
            completion(true)
        }
    }
    
    
    /// Closes the listeners when the app goes into the background
    func detachHolidayListner() {
        for listener in holidayListener {
            listener.remove()
        }
    }
    
}
