//
//  MainHolidayImage.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 26/07/2022.
//

import SwiftUI

struct MainHolidayImage: View {
    
    let holiday: Holiday
    let size: CGFloat
    
    var body: some View {

        ZStack {
            
            // Check if there is an image set
            if holiday.mainImage == "" {
                ZStack {
                    
                    Color("Green1").opacity(0.2)
                    
                    Image(systemName: "photo.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .foregroundColor(Color("Green2"))
                }
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            } else {
                
                // Check if image is cached
                if let cachedImage = CacheService.getImage(forKey: holiday.mainImage!) {
                    
                    cachedImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                } else {
                    
                    // If not in the cached images, download it

                    // Create URL
                    let photoURL = URL(string: holiday.mainImage ?? "")
                    
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
                                .frame(width: size, height: size)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .onAppear {
                                    // Save this image into cache
                                    CacheService.setImage(image: image,
                                                          forKey: holiday.mainImage!)
                                }
                            
                        case .failure:
                            // Couldn't fetch image
                            ZStack {
                                
                                Color("Green1").opacity(0.2)
                                
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(Color("Green2"))
                            }
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            
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
