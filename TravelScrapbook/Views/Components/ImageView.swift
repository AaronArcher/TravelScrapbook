//
//  SwiftUIView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 30/06/2022.
//

import SwiftUI

struct ImageView: View {
    @Environment(\.dismiss) private var dismiss

    var image: UIImage
    
    var body: some View {
        
        ZStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(Color("Green1"))
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                    )
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .padding(.top, 15)
            
        }
        .ignoresSafeArea()

    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
