//
//  ContentView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 28/10/2023.
//

import SwiftUI
import SwiftData

struct ProjectsView: View {
    @Query private var projects: [Project]
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        NavigationStack(path: $stateManager.navigationPath){
            VStack {
                List(projects){ project in
                    NavigationLink(value: project){
                        ProjectCardView(project: project)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false){
                                Button(role: .destructive) {
                                    if let context = project.modelContext {
                                        context.delete(project)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                    }
                    .listRowBackground(project.theme.mainColor)
                }
            }
            .navigationDestination(for: Project.self){ project in
                ProjectDetailsView(project: project)
            }
            .navigationTitle("Project list")
            .toolbar {
                Button(action: {
                    stateManager.isPresentingNewProjectView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New project")
            }
            .sheet(isPresented: $stateManager.isPresentingNewProjectView) {
                NavigationStack{
                    @State var newProject = Project.emptyProject
                    ProjectEditView(project: $newProject)
                    .navigationTitle("New project")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                stateManager.isPresentingNewProjectView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add"){
                                modelContext.insert(newProject)
                                stateManager.isPresentingNewProjectView = false
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProjectsView()
        .modelContainer(previewContainer)
        .environmentObject(StateManager())
}
