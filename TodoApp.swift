//
//  TodoApp.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 20/04/2024.
//

import SwiftUI

@main
struct TodoApp: App {
    @StateObject var stateManager = StateManager()
    
    var body: some Scene {
        #if os(iOS) || os(macOS)
        DocumentGroup(editing: [Project.self, ProjectTask.self, TaskNote.self, ForToday.self, Person.self, Note.self], contentType: .todoData){
            HomeView()
                .environmentObject(stateManager)
        }
        #else
        WindowGroup {
            HomeView()
                .modelContainer(for: [Project.self, ProjectTask.self, TaskNote.self, ForToday.self, Person.self])
                .environmentObject(stateManager)
        }
        #endif
    }
}
