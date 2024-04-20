//
//  ContentView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 28/10/2023.
//

import SwiftUI

struct ProjectsView: View {
    @Binding var projects: [Project]
    @State var isPresentingNewProjectView = false
    
    var body: some View {
        NavigationStack{
            VStack {
                List($projects){ $project in
                    NavigationLink(destination: ProjectDetailsView(project: $project) ){
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
                    .accessibilityLabel("New Scrum")
                }
            }
            .sheet(isPresented: $isPresentingNewProjectView) {
                NewProjectView(projects: $projects, isPresentingNewProjectView: $isPresentingNewProjectView)
            }
        }
    }
}

#Preview {
    return ProjectsView(projects: .constant(Project.sampleProjects))
}
