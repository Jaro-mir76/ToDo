//
//  StateManager.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 26/06/2024.
//

import Foundation
import SwiftUI

class StateManager: ObservableObject {
    
    @Published var navigationPath = NavigationPath()        // Navigation across app
    @Published var navigationPathTab2 = NavigationPath()
    @Published var selectedTab: Int = 1                 // Control over selected tab
    
    @Published var isPresentingNewProjectView = false   // Used to show new project creation View
    
    @Published var parentTask: ProjectTask?     // variable used during task creation to determine place in hierarchy
    
    @Published var activeProject: Project?
    
    @Published var isPresentingNewTask = false  // used to show task creation view
}
