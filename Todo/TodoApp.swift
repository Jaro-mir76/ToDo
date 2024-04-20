//
//  TodoApp.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 20/04/2024.
//

import SwiftUI

@main
struct TodoApp: App {
    @State private var projects = Project.sampleProjects
    
    var body: some Scene {
        WindowGroup {
            ProjectsView(projects: $projects)
        }
    }
}
