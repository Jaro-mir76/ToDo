//
//  TaskCardView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 01/11/2023.
//

import SwiftUI

struct TaskCardView: View {
    @Bindable var task: ProjectsTask
    var isSubGroup: Bool = false
    
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                VStack{
                    HStack{
                        if !task.subTask.isEmpty {
                            HStack {
                                Text("\(task.tasksCompleted)/\(task.tasksCount)")
                                Text(task.taskName)
                                    .font(.headline)
                                Spacer()
                            }
                        } else {
                            if task.taskIsCompleted == true {
                                Label("", systemImage: "checkmark.square")
                            } else {
                                Label("", systemImage: "square")
                            }
                            Text(task.taskName)
                                .font(.headline)
                            Spacer()
                        }
                    }
                    HStack {
                        Label("", systemImage: "figure.walk.motion")
                        Text(task.priority.rawValue)
                        Spacer()
                        Label("", systemImage: "calendar")
                        Text(task.dueDate.formatted(date: .numeric, time: .omitted))
                    }
                    HStack {
                        Label("", systemImage: "stopwatch")
                        Text(task.realImplTimeMinutes.description)
                        Spacer()
                        Label("", systemImage: "flag.checkered")
                        Text(task.estimatedImplTimeMinutes.description)
                        Text("min.")
                    }
                }
            }
        }
    }
}

#Preview {
    return TaskCardView(task: Project.sampleProjects[0].tasks[0], isSubGroup: true)
}
