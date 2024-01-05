//
//  ContentView.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/11/29.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color(red: 0.95, green: 0.90, blue: 0.87))
    }
    
    var body: some View {
        TabView {
            ToDoTimeLine()
                .tabItem {
                    Label("待辦事項", systemImage: "checklist")
                }
            HomePage()
            .tabItem {
                Label("倒數小工具", systemImage: "calendar.badge.clock")
            }
        }
    }
}

#Preview {
    ContentView()
}
