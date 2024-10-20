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
    @Query private var notes: [Note]
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        TabView(selection: $stateManager.selectedTab) {
            ProjectsView()
                .tabItem { Label("Projects", systemImage: "house")}
                .tag(1)
            
            ForTodayView()
                .tabItem { Label("Today", systemImage: "checklist")}
                .tag(2)
                .badge(tasksForToday.count)
            
            NotesView()
                .tabItem { Label("quick Note", systemImage: "pencil.and.list.clipboard")}
                .tag(3)
                .badge(notes.count)
        }
    }
}

#Preview(traits: .modelContainerSampleData) {
    HomeView()
        .environmentObject(StateManager())
}
