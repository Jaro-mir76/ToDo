//
//  TasksEditView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 08/11/2023.
//

import SwiftUI

struct TasksEditView: View {
    @Binding var task: ProjectsTask
    
    var body: some View {
        Form{
            Section(header: Text("Task details")){
                VStack{
                    TextField("Task name", text: $task.taskName)
                    TextField("Task details", text: $task.taskDescryption, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            Section(header: Text("Priority, Required time")){
                HStack{
                    Text("Priority")
                        .font(.footnote)
                        .textCase(.uppercase)
                        .foregroundColor(.gray)
                    Spacer()
                    PriorityPicker(selection: $task.priority)
                }
                HStack{
                    Text("ETA:")
                        .font(.footnote)
                        .textCase(.uppercase)
                        .foregroundColor(.gray)
                    Spacer()
                    TextField("ETA", value: $task.estimatedImplTimeMinutes, formatter: NumberFormatter())
                }
            }
            Section(header: Text("Due date")){
                DatePicker(
                    "Due Date",
                    selection: $task.dueDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            }
        }
    }
}

#Preview {
    return TasksEditView(task: .constant(Project.sampleProjects[0].tasks[0]))
}
