//
//  ProjectEditView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 05/11/2023.
//

import SwiftUI

struct ProjectEditView: View {
    @Binding var project: Project
    @State private var showDatePicker = false
    
    var body: some View {
        Form{
            Section(header: Text("Project info")){
                VStack{
                    TextField("Project name", text: $project.projName)
                    TextField("Project description", text: $project.projDescription, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            PriorityEditView(priority: $project.priority)
            ThemeEditView(theme: $project.theme)
            DuedateEditView(dueDate: $project.dueDate)
        }
    }
}

#Preview {
    return ProjectEditView(project: .constant(Project.sampleProjects[0]))
}
