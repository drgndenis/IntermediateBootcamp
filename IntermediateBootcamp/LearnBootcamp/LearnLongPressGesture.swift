//
//  LongPressGesture.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 7.11.2023.
//

import SwiftUI

struct LearnLongPressGesture: View {
    @State private var isComplate: Bool = false
    @State private var isSuccess: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isComplate ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
            
            HStack {
                Text("CLICK HERE")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .onLongPressGesture(
                        minimumDuration: 1.5,
                        maximumDistance: 50,
                        pressing: { isPressing in
                            if isPressing {
                                withAnimation(.easeInOut(duration: 1.5)) {
                                    isComplate = true
                                }
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if !isSuccess {
                                        withAnimation(.easeInOut(duration: 1.5)) {
                                            isComplate = false
                                        }
                                    }
                                }
                            }
                        },
                        perform: {
                            withAnimation(.easeInOut) {
                                isSuccess = true
                            }
                        })
                
                
                Text("RESET")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isSuccess = false
                            isComplate = false
                        }
                    }
            }
        }
        
        //        Text(isComplate ? "Complated" : "Is not complated")
        //            .padding()
        //            .padding(.horizontal)
        //            .background(isComplate ? .green : .gray)
        ////            .onTapGesture {
        ////                isComplate.toggle()
        ////            }
        //            .onLongPressGesture {
        //                isComplate.toggle()
        //            }
    }
}

#Preview {
    LearnLongPressGesture()
}
