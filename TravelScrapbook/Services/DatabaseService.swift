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
    
    var visitedListener = [ListenerRegistration]()
    var wishlistListener = [ListenerRegistration]()

    
    func setUserProfile(firstname: String, lastname: String, email: String, completion: @escaping (Bool) -> Void) {
     
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
                     "email": email]) { error in
            
            if error == nil {
                // Save successful
                completion(true)
            } else {
                // Failed to save
                completion(false)
            }
            
        }
        
    }
    
    /// This method gets all visited items from the database created by the signed in user
    func getVisited(completion: @escaping ([Holiday]) -> Void ) {
     
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Perform a query against the holiday collection for any holidays where the createdBy field is the logged in user ID
//        let holidaysQuery = db.collection("holidays")
//            .whereField("createdBy", isEqualTo: AuthViewModel.getLoggedInUserID())
        
        let holidaysQuery = db.collection("users").document(AuthViewModel.getLoggedInUserID()).collection("visited")
//            .order(by: "date") // This is creating issues with the listener and not pushing the same data between devices
        
        let listener = holidaysQuery.addSnapshotListener { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var holidays = [Holiday]()
                
                for doc in snapshot!.documents {
                    
                    let data = doc.data()
                    let id = doc.documentID
                    let title = data["title"] as? String ?? ""
                    let isWishlist = data["isWishlist"] as? Bool ?? false
//                    let createdBy = data["createdBy"] as? String ?? ""
                    let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                    let city = data["city"] as? String ?? ""
                    let country = data["country"] as? String ?? ""
                    let locationID = data["locationID"] as? String ?? ""
                    let latitude = data["latitude"] as? Double ?? 0
                    let longitude = data["longitude"] as? Double ?? 0
                    let visitedWith = data["visitedWith"] as? String ?? ""
                    let thumbnailImage = data["thumbnailImage"] as? String ?? ""

//                    print(mainImage)
                    
                    holidays.append(Holiday(id: id,
//                                            createdBy: createdBy,
                                            title: title,
                                            isWishlist: isWishlist,
                                            visitedWith: visitedWith,
                                            date: date,
                                            location: Location(id: locationID,
                                                               city: city,
                                                               country: country,
                                                               latitude: latitude,
                                                               longitude: longitude),
                                            thumbnailImage: thumbnailImage))
                    
                
                }
                
                completion(holidays)
                
            } else {
                // there was an error
                print("error retrieving holidays")
            }
        }
        // Keep track of the listener so we can close it later
        visitedListener.append(listener)
       
    }
    
    /// This method gets all wishlist items from the database created by the signed in user
    func getWishlist(completion: @escaping ([Holiday]) -> Void ) {
     
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Perform a query against the holiday collection for any holidays where the createdBy field is the logged in user ID
//        let holidaysQuery = db.collection("holidays")
//            .whereField("createdBy", isEqualTo: AuthViewModel.getLoggedInUserID())
        
        let holidaysQuery = db.collection("users").document(AuthViewModel.getLoggedInUserID()).collection("wishlist")
//            .order(by: "date") // This is creating issues with the listener and not pushing the same data between devices
        
        let listener = holidaysQuery.addSnapshotListener { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var holidays = [Holiday]()
                
                for doc in snapshot!.documents {
                    
                    let data = doc.data()
                    let id = doc.documentID
                    let title = data["title"] as? String ?? ""
                    let isWishlist = data["isWishlist"] as? Bool ?? false
//                    let createdBy = data["createdBy"] as? String ?? ""
                    let city = data["city"] as? String ?? ""
                    let country = data["country"] as? String ?? ""
                    let locationID = data["locationID"] as? String ?? ""
                    let latitude = data["latitude"] as? Double ?? 0
                    let longitude = data["longitude"] as? Double ?? 0

//                    print(mainImage)
                    
                    holidays.append(Holiday(id: id,
//                                            createdBy: createdBy,
                                            title: title,
                                            isWishlist: isWishlist,
                                            location: Location(id: locationID,
                                                               city: city,
                                                               country: country,
                                                               latitude: latitude,
                                                               longitude: longitude)))
                    
                
                }
                
                completion(holidays)
                
            } else {
                // there was an error
                print("error retrieving holidays")
            }
        }
        // Keep track of the listener so we can close it later
        wishlistListener.append(listener)
       
    }
    
    /// Creates a new holiday in the visited category/collection
    func createHoliday(title: String, date: Date, locationID: String, city : String, country: String, latitude: Double, longitude: Double, visitedWith: String, thumbnailImage: UIImage?, completion: @escaping (Bool, String?) -> Void) {
     
        // Get reference to database
        let db = Firestore.firestore()
        
            //         Create a document
                    let doc = db.collection("users")
                        .document(AuthViewModel.getLoggedInUserID())
                        .collection("visited")
                        .addDocument(data: ["title" : title,
                                            "isWishlist" : false,
                                            "date" : date,
                                           "locationID" : locationID,
                                           "city" : city,
                                           "country" : country,
                                           "latitude" : latitude,
                                           "longitude" : longitude,
                                            "visitedWith" : visitedWith,
                                            "thumbnailImage" : ""])

                    if let thumbnailImage = thumbnailImage {

                        // Create storage reference
                        let storageRef = Storage.storage().reference()

                        // Turn image into data and reduce size
            //            let imageData = mainImage.jpegData(compressionQuality: 0.0)
                          let smallerImage = ImageHelper.compressImage(image: thumbnailImage)
                          let imageData = smallerImage.jpegData(compressionQuality: 0.2)

                        // Check we were able to convert it into data
                        guard imageData != nil else { return }

                        // specify the filePath and name
                        let path = "images/\(doc.documentID).jpg"
                        let fileRef = storageRef.child(path)

                        let uploadTask = fileRef.putData(imageData!, metadata: nil) { meta, error in

                            if error == nil && meta != nil {
                                // Get full URL to image
                                fileRef.downloadURL { url, error in

                                    if url != nil && error == nil {

                                        doc.setData(["thumbnailImage" : url!.absoluteString], merge: true) { error in
                                            if error == nil {
                                                // Main image Success, notify caller
                                                completion(true, "")


                                            }
                                        }

                                    } else {
                                        // Wasn't successful grabbing the url for the main image
                                        completion(false, error?.localizedDescription)
                                    }

                                }

                            } else {
                                // Main Image upload wasn't successful, notify caller
                                completion(false, error?.localizedDescription)
                            }

                        }

                    } else {
                        // No image set
                        completion(true, "")

                    }
        
    
    }
    
    /// creates a new holiday in the wishlist category/collection
    func createWishlistHoliday(title: String, date: Date, locationID: String, city : String, country: String, latitude: Double, longitude: Double, completion: @escaping (Bool, String?) -> Void) {

        // Get reference to database
        let db = Firestore.firestore()

        // Create a document
        let doc = db.collection("users")
            .document(AuthViewModel.getLoggedInUserID())
            .collection("wishlist")

        doc.addDocument(data: ["title" : title,
                               "isWishlist" : true,
                               "date" : date,
                               "locationID" : locationID,
                               "city" : city,
                               "country" : country,
                               "latitude" : latitude,
                               "longitude" : longitude]) { error in
            if error == nil {
                completion(true, "")
            } else {
                completion(false, error?.localizedDescription)
            }
        }

    }
    
    /// Edits a visited holiday
    func editVisitedHoliday(holiday: Holiday, title: String, visitedWith: String, city: String, country: String, date: Date, newImage: UIImage?, completion: @escaping (Bool, String?) -> Void) {
        
        var newTitle = title
        var newVisitedWith = visitedWith
        var newCity = city
        var newCountry = country
        if newTitle == "" { newTitle = holiday.title }
        if newVisitedWith == "" { newVisitedWith = holiday.visitedWith ?? "" }
        if newCity == "" { newCity = holiday.location.city }
        if newCountry == "" { newCountry = holiday.location.country }
        
        // Get reference to database
        let db = Firestore.firestore()
        
        // Get specific document
        let doc = db.collection("users")
            .document(AuthViewModel.getLoggedInUserID())
            .collection("visited")
            .document(holiday.id ?? "")
        
        doc.setData(["title" : newTitle,
                     "visitedWith" : newVisitedWith,
                     "date" : date,
                     "city" : newCity,
                     "country" : newCountry], merge: true) { error in
            
            if error == nil {
                
                completion(true, "")
                // No error, continue and check if there is a new image
                if let newImage = newImage {

                    // Create storage reference
                    let storageRef = Storage.storage().reference()

                    // Turn image into data and reduce size
        //            let imageData = mainImage.jpegData(compressionQuality: 0.0)
                      let smallerImage = ImageHelper.compressImage(image: newImage)
                      let imageData = smallerImage.jpegData(compressionQuality: 0.2)

                    // Check we were able to convert it into data
                    guard imageData != nil else { return }

                    // specify the filePath and name
                    let path = "images/\(doc.documentID).jpg"
                    let fileRef = storageRef.child(path)

                    let uploadTask = fileRef.putData(imageData!, metadata: nil) { meta, error in

                        if error == nil && meta != nil {
                            // Get full URL to image
                            fileRef.downloadURL { url, error in

                                if url != nil && error == nil {

                                    doc.setData(["thumbnailImage" : url!.absoluteString], merge: true) { error in
                                        if error == nil {
                                            // Main image Success, notify caller
                                            completion(true, "")


                                        }
                                    }

                                } else {
                                    // Wasn't successful grabbing the url for the main image
                                    completion(false, error?.localizedDescription)
                                }

                            }

                        } else {
                            // Main Image upload wasn't successful, notify caller
                            completion(false, error?.localizedDescription)
                        }

                    }

                } else {
                    // No image set
                    completion(true, "")

                }
                
            } else {
                // Error occured
                completion(false, error?.localizedDescription)
            }
            
        }
        
        
    }
    
    /// Edits a wishlist holiday
    func editWishlistHoliday(holiday: Holiday, title: String, city: String, country: String, completion: @escaping (Bool, String?) -> Void) {
        
        var newTitle = title
        var newCity = city
        var newCountry = country
        if newTitle == "" { newTitle = holiday.title }
        if newCity == "" { newCity = holiday.location.city }
        if newCountry == "" { newCountry = holiday.location.country }
        
        // Get reference to database
        let db = Firestore.firestore()
        
        // Get specific document
        let doc = db.collection("users")
            .document(AuthViewModel.getLoggedInUserID())
            .collection("wishlist")
            .document(holiday.id ?? "")
        
        doc.setData(["title" : newTitle,
                     "city" : newCity,
                     "country" : newCountry], merge: true) { error in
            
            if error == nil {
                completion(true, "")
            } else {
                completion(false, error?.localizedDescription)
            }
            
        }
        
    }
    
    /// Deletes the holiday and any thumbnail image passed through
    func deleteHoliday(holiday: Holiday, completion: @escaping (Bool, String?) -> Void) {
        
        var selectedCategory = ""
        
        if holiday.isWishlist {
            selectedCategory = "wishlist"
        } else {
            selectedCategory = "visited"
        }
        
        let db = Firestore.firestore()
        
        let doc = db.collection("users")
            .document(AuthViewModel.getLoggedInUserID())
            .collection(selectedCategory)
            .document(holiday.id ?? "")
        
        doc.delete() { error in
            
            if error == nil {
                
                if holiday.thumbnailImage != "" && holiday.thumbnailImage != nil {
                    // need to delete this image from Storage
                    
                    let storageRef = Storage.storage().reference()
                    let path = "images/\(holiday.id ?? "").jpg"
                    let fileRef = storageRef.child(path)

                    fileRef.delete { error in
                        
                        if error == nil {
                            // deletion successful
                            completion(true, "")
                        } else {
                            // error occured
                            completion(false, error?.localizedDescription)
                        }
                        
                    }
                    
                } else {
                    // no image, deletion successful
                    completion(true, "")
                }
                
            } else {
                completion(false, error?.localizedDescription)
            }
            
        }
        
        
    }
    
    /// Closes the listeners when the app goes into the background
    func detachHolidayListner() {
        for listener in visitedListener {
            listener.remove()
        }
        for listener in wishlistListener {
            listener.remove()
        }
    }
    
}
