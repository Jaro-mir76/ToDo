//
//  ProjectEditView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 05/11/2023.
//

import SwiftUI
import SwiftData

struct ProjectEditView: View {
    @Binding var project: Project
    
    var body: some View {
        Form{
            Section(header: Text("Project info")){
                VStack{
                    TextField("Project name", text: $project.projName)
                    TextField("Project description", text: $project.projDescription, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            PriorityPicker(selection: $project.priority)
            ThemePicker(selection: $project.theme)
            DuedateEditView(dueDate: $project.dueDate)
        }
    }
}

#Preview(traits: .modelContainerSampleData) {
    ProjectEditView(project: .constant(Project.sampleProjects[0]))
}
