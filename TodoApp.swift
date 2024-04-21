//
//  TodoApp.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 20/04/2024.
//

import SwiftUI

@main
struct TodoApp: App {
    
    var body: some Scene {
        #if os(iOS) || os(macOS)
        DocumentGroup(editing: [Project.self, ProjectsTask.self, TasksNote.self], contentType: .todoData){
            ProjectsView()
        }
        #else
        WindowGroup {
            ProjectsView()
                .modelContainer(for: [Project.self, ProjectsTask.self, TasksNote.self])
                .environment(\.selectedProject, $selectedProject)
        }
        #endif
    }
}
