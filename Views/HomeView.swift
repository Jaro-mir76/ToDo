//
//  HomeView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 16/06/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var tasksForToday: [ForToday]
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        TabView(selection: $stateManager.selectedTab) {
            ProjectsView()
                .tabItem { Label("Projects", systemImage: "house")}
                .tag(1)
            
            ForTodayView()
                .tabItem { Label("for Today", systemImage: "checklist")}
                .tag(2)
                .badge(tasksForToday.count)
            
            Text("Tab Content 3 but soon you'll find place for making Quick Notes")
                .tabItem { Label("quick Note", systemImage: "pencil.and.list.clipboard")}
                .tag(3)
                .badge(stateManager.navigationPath.count)
        }
    }
}

#Preview(traits: .modelContainerSampleData) {
    HomeView()
        .environmentObject(StateManager())
}
