//
//  HomeView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 23/06/2022.
//

import SwiftUI
import MapKit

struct RootView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var holidayvm: HolidayViewModel
    @EnvironmentObject var mapvm: MapViewModel
    
    //    @State private var showOnboarding = !AuthViewModel.isUserLoggedIn()
    @State private var showLogin = !AuthViewModel.isUserLoggedIn()
    
    @State private var showSearch = false
    @State private var showSearchContent = false
    
    @State private var showAddNewHoliday = false
    @State private var showAddNewHolidayContent = false
    
    @State private var holidayCity = ""
    @State private var holidayCountry = ""
    
    @Namespace var namespace

    @State private var showMap = true
    @State var showMarker = false
    @State var showCancel = false
    @State private var showSetting = false
    
    
    var body: some View {
        
        if showLogin {
            LoginView(showLogin: $showLogin)

        } else {
            ZStack {
                HStack {
                    Button {
                        withAnimation {
                            showMap.toggle()
                        }
                    } label: {
                        ZStack {
                            
                            Image(systemName: "map")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .offset(x: showMap ? -80 : 0)
                            
                            Image(systemName: "list.bullet")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .offset(x: showMap ? 0 : 80)
                        }
                        .padding(10)
                        .mask({ Circle() })
                        .background(
                            Circle()
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                        )
                    }
                    .offset(x: (showSearch || showAddNewHoliday) ? -80 : 0)
                    
                    Spacer()
                    
                    if !showSearch {
                        SearchButton(showSearch: $showSearch,
                                     showSearchContent: $showSearchContent,
                                     namespace: namespace)
                        .offset(y: showAddNewHoliday || !showMap ? -100 : 0)
                        .disabled(!showMap)
                    }
                    
                    Spacer()
                    
                    Button {
                        showSetting = true
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(10)
                            .background(
                                Circle()
                                    .foregroundColor(.white)
                                    .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                            )
                    }
                    .offset(x: (showSearch || showAddNewHoliday) ? 80 : 0)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(15)
                .padding(.top, Constants.isScreenLarge ? 40 : 20)
                
                
                mapOrList
                .clipShape(RoundedCornerShape(radius: 25, corners: [.topLeft, .topRight]))
                .frame(maxHeight: Constants.screenHeight / 1.18)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .shadow(color: Color("Green2").opacity(0.3), radius: 15, x: 5, y: 5)
                .overlay {
                    if showAddNewHoliday || showSearch {
                        Color.gray.opacity(0.5)
                    }
                }
                
                VStack {
                    
                    if showSearch {
                        SearchView(showSearch: $showSearch,
                                   showSearchContent: $showSearchContent,
                                   holidayCity: $holidayCity,
                                   holidayCountry: $holidayCountry,
                                   namespace: namespace)
                    }
                    
                    if showAddNewHoliday {
                        // Show add new holiday pop up
                        AddNewHolidayView(showAddNewHoliday: $showAddNewHoliday,
                                      showAddNewHolidayContent: $showAddNewHolidayContent,
                                      showMarker: $showMarker,
                                      showCancel: $showCancel,
                                      holidayCity: $holidayCity,
                                      holidayCountry: $holidayCountry,
                                      namespace: namespace)
                    }
                    
                    Spacer()
                    
                }
                .frame(maxHeight: .infinity)
            }
            .foregroundColor(Color("Green1"))
            .ignoresSafeArea()
            .background(
                LinearGradient(colors: [Color("Background"), Color("Green3"), Color("Green3")], startPoint: .top, endPoint: .bottom)
            )
//            .fullScreenCover(isPresented: $showLogin, onDismiss: {
//                holidayvm.getholidays()
//            }) {
//                LoginView(showLogin: $showLogin)
//            }
            .onAppear {
                if AuthViewModel.isUserLoggedIn() {
                    holidayvm.getholidays()
                }
            }
            .onChange(of: scenePhase) { newPhase in
                
                if newPhase == .active {
                    print("Active")
                    // if user sends app to background, cached images break and do not reload, call this function when coming back to active to fix this
                    if AuthViewModel.isUserLoggedIn() {
                        holidayvm.getholidays()
                    }
                    
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                    holidayvm.holidayCleanup()
                }
                
            }
            .fullScreenCover(isPresented: $showSetting) {
                SettingsView(showLogin: $showLogin)
            }
        }
        
    }
    
    
    @ViewBuilder
    var mapOrList: some View {
        
        if showMap {
            MapView(namespace: namespace,
                    showMarker: $showMarker,
                    showCancel: $showCancel,
                    openSearch: $showSearch,
                    showSearchContent: $showSearchContent,
                    addNewHoliday: $showAddNewHoliday,
                    showAddNewHolidayContent: $showAddNewHolidayContent)
            .transition(.move(edge: .trailing))
        } else {
            ListView()
                .transition(.move(edge: .leading))
        }
    }
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HolidayViewModel()
        RootView()
            .environmentObject(vm)
    }
}
