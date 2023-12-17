//
//  ContentView.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/11/29.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Label("倒數小工具", systemImage: "calendar.badge.clock")
                }
            ToDoTimeLine()
                .tabItem {
                    Label("待辦事項", systemImage: "checklist")
                }
        }
    }
}

#Preview {
    ContentView()
}
