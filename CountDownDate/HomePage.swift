//
//  HomePage.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/12/2.
//

import SwiftUI

struct HomePage: View {
    
    @State var selectId: Int = 0
    @State private var scrollOffset: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal){
                HStack(alignment:.center){
                    ForEach(0..<5) { i in
                        Rectangle()
                            .frame(width: 200,height: 200)
                            .containerRelativeFrame(.horizontal, count:1, spacing:20)
                            .cornerRadius(20)
                            .id(i)
                            .scrollTransition { content,phase in
                                content.opacity(phase.isIdentity ? 1.0:0.5)
                                    .scaleEffect(phase.isIdentity ? 1.0:0.6)

                            }
                    }
                }
                .scrollTargetLayout()
                .padding(.bottom,14)
                //            .border(.black)
                
            }.contentMargins(100)
                .scrollTargetBehavior(.viewAligned)
            
            Button(action: {
                
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }
    }
}

#Preview {
    HomePage()
}
