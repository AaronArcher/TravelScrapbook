//
//  SearchButton.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 20/09/2022.
//

import SwiftUI

struct SearchButton: View {
    
    @Binding var showSearch: Bool
    @Binding var showSearchContent: Bool
    
    let namespace: Namespace.ID
    
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showSearch = true
            }
            withAnimation(.default.delay(0.2)) {
                showSearchContent = true
            }
        } label: {
            Text("SEARCH")
                .matchedGeometryEffect(id: "search", in: namespace)
                .foregroundColor(Color("Green1"))
                .font(.callout)
                .padding(6)
                .padding(.horizontal)
                .mask {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                }
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "bg", in: namespace)
                        .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                )
        }
    }
}

