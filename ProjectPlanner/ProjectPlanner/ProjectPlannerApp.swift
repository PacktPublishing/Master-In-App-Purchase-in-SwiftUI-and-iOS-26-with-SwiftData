//
//  ProjectPlannerApp.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/13/26.
//

import SwiftUI
import SwiftData

@main
struct ProjectPlannerApp: App {
    //@StateObject private var store = ProductStoreKit(productIds: ProductIDList.allCases.map(\.rawValue))
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ProjectItem.self)
    //    .environmentObject(store)
        
    }
}
