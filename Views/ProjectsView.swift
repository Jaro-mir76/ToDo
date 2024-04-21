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
    @State private var isPresentingNewProjectView = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        NavigationStack{
            VStack {
                List(projects){ project in
                    NavigationLink(destination: ProjectDetailsView(project: project)){
                        ProjectCardView(project: project)
                    }
                    .listRowBackground(project.theme.mainColor)
                }
                .navigationTitle("Lista projektów")
                .toolbar {
                    Button(action: {
                        isPresentingNewProjectView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New project")
                }
            }
            .sheet(isPresented: $isPresentingNewProjectView) {
                NavigationStack{
                    @State var newProject = Project.emptyProject
                    ProjectEditView(project: $newProject)
                        .navigationTitle("New project")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction){
                                Button("Cancel"){
                                    isPresentingNewProjectView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Add"){
                                    modelContext.insert(newProject)
                                    isPresentingNewProjectView = false
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
}
