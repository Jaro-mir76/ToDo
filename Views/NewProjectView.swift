//
//  NewProjectView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 10/11/2023.
//

import SwiftUI
import SwiftData

struct NewProjectView: View {
    @State private var newProject = Project.emptyProject
    @Binding var isPresentingNewProjectView: Bool
    @Environment(\.modelContext) private var modelContext
    
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
                            modelContext.insert(newProject)
                            isPresentingNewProjectView = false
                        }
                    }
                }
        }
    }
}

#Preview {
    NewProjectView(isPresentingNewProjectView: .constant(true))
        .modelContainer(previewContainer)
}
