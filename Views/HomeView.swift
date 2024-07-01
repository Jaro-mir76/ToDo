//
//  HomeView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 16/06/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
//    @State private var selectedTab: Int = 2
    @Query private var tasksForToday: [ForToday]
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        TabView(selection: $stateManager.selectedTab) {
            ProjectsView()
                .tabItem { Label("Projects", systemImage: "house")}
                .tag(1)
            
            ForTodayView()
                .tabItem { Label("For today", systemImage: "checklist")}
                .tag(2)
//            .frame(height: 200)
//            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .badge(tasksForToday.count)
            
            Text("Tab Content 3")
                .tabItem { Label("Quick note", systemImage: "pencil.and.list.clipboard")}
                .tag(3)
                .badge(stateManager.navigationPath.count)
        }
    }
}

#Preview {
    HomeView()
}
