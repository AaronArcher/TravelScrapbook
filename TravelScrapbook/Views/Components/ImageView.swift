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
    
    @State private var currentScale: CGFloat = 1
    @State private var finalScale: CGFloat = 1
    private let minScale = 1.0
    private let maxScale = 5.0
    
    @State private var offset: CGSize = .zero
    @State private var newOffset: CGSize = .zero
    

    var body: some View {
        
        ZStack {
            
            
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(currentScale)
                    .offset(offset)
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ newScale in
                                adjustScale(from: newScale)
                            })
                            .onEnded({ scale in
                                withAnimation(.spring()) {
                                    validateScaleLimits()
                                    if currentScale <= 1 {
                                        newOffset = .zero
                                        offset = .zero
                                    }
                                }
                                finalScale = 1
                            })
                    )
                    .simultaneousGesture(
                        DragGesture()
                            .onChanged({ state in
                                    if currentScale > 1 {
                                        offset = CGSize(width: state.translation.width + newOffset.width, height: state.translation.height + newOffset.height)
                                     
                                }
                            })
                            .onEnded({ _ in
                                    if currentScale > 1 {
                                        newOffset = offset
                                    }
                            })
                    )

            
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
        .clipped()

    }
    
    func adjustScale(from state: MagnificationGesture.Value) {
        let delta = state / finalScale
        currentScale *= delta
        finalScale = state
    }

    // Set Scale Limits
    func getMinimumScaleAllowed() -> CGFloat {
        return max(currentScale, minScale)
    }

    func getMaximumScaleAllowed() -> CGFloat {
        return min(currentScale, maxScale)
    }

    func validateScaleLimits() {
        currentScale = getMinimumScaleAllowed()
        currentScale = getMaximumScaleAllowed()
    }
    
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
