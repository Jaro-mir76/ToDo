//
//  ProjectEditView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 05/11/2023.
//

import SwiftUI

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
            HStack{
                Text("Priority")
                    .font(.footnote)
                    .textCase(.uppercase)
                    .foregroundColor(.gray)
                Spacer()
                PriorityPicker(selection: $project.priority)
            }
            HStack{
                Text("Theme")
                    .font(.footnote)
                    .textCase(.uppercase)
                    .foregroundColor(.gray)
                Spacer()
                ThemePicker(selection: $project.theme)
            }
            Section(header: Text("Due date")){
                    DatePicker(
                            "Due Date",
                            selection: $project.dueDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical)
                }
        }
    }
}

#Preview {
    return ProjectEditView(project: .constant(Project.sampleProjects[0]))
}
