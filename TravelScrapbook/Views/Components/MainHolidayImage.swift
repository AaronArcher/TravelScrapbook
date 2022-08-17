//
//  MainHolidayImage.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 26/07/2022.
//

import SwiftUI

struct MainHolidayImage: View {
    
    let holiday: Holiday
    let iconSize: CGFloat
    
    var body: some View {

        ZStack {
            
            // Check if there is an image set
            if holiday.thumbnailImage == "" || holiday.thumbnailImage == nil {
                ZStack {
                    
                    Color("Green1").opacity(0.2)
                    
                    Image(systemName: "photo.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(Color("Green2"))
                }

            } else {
                
                // Check if image is cached
                if let cachedImage = CacheService.getImage(forKey: holiday.thumbnailImage ?? "") {
                    
                    cachedImage
                        .resizable()
                        .scaledToFill()
                    
                } else {
                    
                    // If not in the cached images, download it

                    // Create URL
                    let photoURL = URL(string: holiday.thumbnailImage ?? "")
                    
                    AsyncImage(url: photoURL) { phase in
                        
                        switch phase {
                            
                        case .empty:
                            // Currently Fetching
                            ProgressView()
                            
                        case .success(let image):
                            // Display the fetched image
                            image
                                .resizable()
                                .scaledToFill()
                                .onAppear {
                                    // Save this image into cache
                                    CacheService.setImage(image: image,
                                                          forKey: holiday.thumbnailImage!)
                                }
                            
                        case .failure:
                            // Couldn't fetch image
                            ZStack {
                                
                                Color("Green1").opacity(0.2)
                                
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: iconSize, height: iconSize)
                                    .foregroundColor(Color("Green2"))
                            }
                            
                        }

                        
                    }

                    
                }
                
                
            }
            
        }

    }
}

//struct MainHolidayImage_Previews: PreviewProvider {
//    static var previews: some View {
//        MainHolidayImage()
//    }
//}
