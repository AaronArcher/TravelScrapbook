//
//  SettingsView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 31/07/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var holidayViewModel: HolidayViewModel
    
    @Binding var showLogin: Bool
    
    var body: some View {
        
            
            VStack {
                
                Button {
                    dismiss()
                } label: {
                    
                    Text("Close")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }

                
                Text("Show:")
                HStack(spacing: 20) {
                    
                    Button {
                        holidayViewModel.selectedCategory = .all
                    } label: {
                        Text("All")
                    }
                    
                    Button {
                        holidayViewModel.selectedCategory = .visited
                    } label: {
                        Text("Visited")
                    }

                    Button {
                        holidayViewModel.selectedCategory = .wishlist
                    } label: {
                        Text("Wishlist")
                    }
                    
                }
                    
                    Spacer()
                    
                    Button {
                        
                        dismiss()
                        
                        AuthViewModel.logOut()
                        showLogin = !AuthViewModel.isUserLoggedIn()
                        
                    } label: {
                        Text("Sign Out")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(
                                Capsule()
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity)
                            )
                    }
                    .padding(.bottom, 30)
                
                
                
                

                
            }
            .padding()
            .padding(.top)
            
        
        
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
