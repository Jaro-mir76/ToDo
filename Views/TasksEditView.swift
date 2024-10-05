//
//  TasksEditView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 08/11/2023.
//

import SwiftUI

struct TasksEditView: View {
    @Binding var task: ProjectTask
    @State private var showTimeWheel = false
    
    var body: some View {
        Form{
            Section(header: Text("Task details")){
                VStack{
                    TextField("Task name", text: $task.taskName)
                    TextField("Task details", text: $task.taskDescryption, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            Section(){
                PriorityPicker(selection: $task.priority)
                TaskDurationPicker(task: $task)
                DuedateEditView(dueDate: $task.dueDate)
            }            
        }
    }
}

#Preview(traits: .modelContainerSampleData) {
    return TasksEditView(task: .constant(Project.sampleProjects[0].tasks[0]))
}
