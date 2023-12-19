//
//  CountDownDateApp.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/11/29.
//

import SwiftUI
import SwiftData

@main
struct CountDownDateApp: App {
    
//    let contanier: ModelContainer = {
//        let schema = Schema([DataFormat.self])
//        let contanier = try! ModelContainer(for: schema, configurations: [])
//        return contanier
//    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [DataFormat.self])
    }
}
