//
//  ProjectEditView.swift
//  Wagoniki
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
                    TextField("Project name", text: $project.name)
                    TextField("Project description", text: $project.description, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            Section(header: Text("Theme")){
                ThemePicker(selection: $project.theme)
            }
            Section(header: Text("Priority")){
                PriorityPicker(selection: $project.priority)
            }
            Section(header: Text("Due date")){
                    //Due date
                    /*HStack{
                        Text("Due date")
                        Spacer()
                        Text(project.dueDate.formatted(date: .abbreviated, time: .omitted).description)
                    }*/
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
