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
    @State private var filterOptions = ["All Locations", "Visited Locations", "Wishlist Locations"]
    @State private var selectedFilter = "All Locations"

    
    var body: some View {
        
        NavigationView {
            
            List {
            
                HStack {
                    
                    Text("Filter By:")
                        .foregroundColor(Color("Green2"))
                    
                    Spacer()
                    
                    Picker("Filter by:", selection: $holidayViewModel.selectedCategory) {
                        ForEach(SelectedCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .foregroundColor(Color("Green1"))
                        }
                    }
                    .accentColor(Color("Green1"))
                    .pickerStyle(.menu)
                }
                
            
            }
            .listStyle(.plain)
            .padding(.top)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                        dismiss()
                        
                        holidayViewModel.holidayCleanup()
                        AuthViewModel.logOut()
                        showLogin = !AuthViewModel.isUserLoggedIn()
                        
                    } label: {
                        Text("Log Out")
                            .font(.callout)
                            .foregroundColor(Color("Green1"))
                        }
                }
                
            }
            
        }
        
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
