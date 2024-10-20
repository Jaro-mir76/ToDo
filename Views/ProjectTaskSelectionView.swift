//
//  ProjectTaskSelectionView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 06/10/2024.
//

import SwiftUI
import SwiftData

struct ProjectTaskSelectionView: View {
    @Query
    private var projects: [Project]
    @EnvironmentObject var stateManager: StateManager
    @State private var newTask = ProjectTask.emptyTask
    var note: String
    
    var body: some View {
            Form {
                ForEach (projects) { project in
                    Section {
                        Button {
                            newTask.taskName = "New task"
                            newTask.taskDescryption = note.description
                            newTask.project = project
                            stateManager.activeProject = project
                            stateManager.parentTask = nil
                            newTask.parentTask = nil
                            stateManager.isPresentingNote2ProjectPhase2 = true
                        } label: {
                            ProjectCardView(project: project)
                        }
                        .listRowBackground(project.theme.mainColor)
                        ForEach(project.tasks) { task in
                            if !task.subTask.isEmpty {
                                Button {
                                    newTask.taskName = "New task"
                                    newTask.taskDescryption = note.description
                                    newTask.project = project
                                    newTask.parentTask = task
                                    stateManager.activeProject = project
                                    stateManager.parentTask = task
                                    stateManager.isPresentingNote2ProjectPhase2 = true
                                } label: {
                                    Text(task.taskName)
                                }
                            }
                        }
                        .listRowBackground(project.theme.mainColor)
                    }
                }
            }
            .navigationDestination(isPresented: $stateManager.isPresentingNote2ProjectPhase2){
                TasksEditView(task: $newTask)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add", action: {
                                if stateManager.parentTask == nil {
                                    if let project = stateManager.activeProject {
                                        project.tasks.append(newTask)
                                    }
                                    stateManager.isPresentingNote2ProjectPhase1 = false
                                    stateManager.isPresentingNote2ProjectPhase2 = false
                                } else {
                                    if let subProject = stateManager.parentTask {
                                        subProject.subTask.append(newTask)
                                    }
                                    stateManager.isPresentingNote2ProjectPhase1 = false
                                    stateManager.isPresentingNote2ProjectPhase2 = false
                                }
                                if let context = stateManager.note2Transfer?.modelContext {
                                    context.delete(stateManager.note2Transfer!)
                                }
                            })
                        }
                    }
            }
    }
}

#Preview(traits: .modelContainerSampleData) {
    ProjectTaskSelectionView(note: "My test note...")
        .environmentObject(StateManager())
}
