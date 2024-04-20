//
//  NewProjectView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 10/11/2023.
//

import SwiftUI

struct NewProjectView: View {
    @Binding var projects: [Project]
    @State private var newProject = Project.emptyProject
    @Binding var isPresentingNewProjectView: Bool
    
    var body: some View {
        NavigationStack{
            ProjectEditView(project: $newProject)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel"){
                            isPresentingNewProjectView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Add"){
                            projects.append(newProject)
                            isPresentingNewProjectView = false
                        }
                    }
                }
        }
    }
}

#Preview {
    return NewProjectView(projects: .constant(Project.sampleProjects), isPresentingNewProjectView: .constant(true))
}
