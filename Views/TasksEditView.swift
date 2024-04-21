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
            Section(header: Text("Tasks details")){
                VStack{
                    TextField("Tasks name", text: $task.taskName)
                    TextField("Tasks description", text: $task.taskDescryption, axis: .vertical)
                        .lineLimit(5...10)
                    PriorityPicker(selection: $task.priority)
                    HStack{
                        Text("Due date")
                        Spacer()
                    }
                    DatePicker(
                            "Due Date",
                            selection: $task.dueDate,
                            displayedComponents: [.date]
                        )
                    .datePickerStyle(.graphical)
                    
                    HStack{
                        Text("ETA:")
                        Spacer()
                        TextField("ETA", value: $task.estimatedImplTimeMinutes, formatter: NumberFormatter())
                    }
                }
            }
        }
    }
}

#Preview {
    return TasksEditView(task: .constant(Project.sampleProjects[0].tasks[0]))
}
