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
    @AppStorage("isDarkMode") var isDarkMode = false
    
    @Binding var showLogin: Bool
    @State private var filterOptions = ["All Locations", "Visited Locations", "Wishlist Locations"]
    @State private var selectedFilter = "All Locations"
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                Section("Profile") {
                    NavigationLink {
                        
                    } label: {
                        Text("Edit Profile")
                    }
                    
                }
                
                Section("Preferences") {
                    
                    Picker("Filter by:", selection: $holidayViewModel.selectedCategory) {
                        ForEach(SelectedCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                        }
                    }
                    .accentColor(Color("PrimaryGreen"))
                    .pickerStyle(.menu)
                    
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .tint(Color("Green1"))
                    
                    
                }
                
                
                
            }
            .listStyle(.insetGrouped)
            .padding(.top)
            .preferredColorScheme(isDarkMode ? .dark : .light)
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
                            .foregroundColor(Color("PrimaryGreen"))
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
