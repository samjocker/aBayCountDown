//
//  PageTest.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2024/1/5.
//

import SwiftUI

struct PageTest: View {
    var colors: [Color] = [ .orange, .green, .yellow, .pink, .purple ]
    var emojis: [String] = [ "👻", "🐱", "🦊" , "👺", "🎃"]
    
    var body: some View {
        VStack{
            TabView() {
                
                ForEach(0..<emojis.count) { index in
                    Text(emojis[index])
                        .font(.system(size: 150))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 250)
                        .background(colors[index])
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .padding()
                        .tabItem {
                            Text(emojis[index])
                        }
                }
                
            }.tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }.frame(height:350)
        
    }
}

#Preview {
    PageTest()
}
