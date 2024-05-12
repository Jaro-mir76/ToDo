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
//            HStack{
//                if let _ = task.subTask {
//                    SubListUnfold(unFold: $task.subTaskUnfold)
//                }
                VStack{
                    HStack{
                        if task.subTask?.count != 0 {
                            HStack {
                                SubTasksStatus(task: task)
                                Text(task.taskName)
                                    .font(.headline)
                                Spacer()
                            }
                        } else {
                            Label("", systemImage: task.taskIsCompleted ? "checkmark.square" : "square")
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
                        TimeDurationView(duration: task.realImplTimeMinutes)
                        Spacer()
                        Label("", systemImage: "flag.checkered")
                        Text(task.estimatedImplTimeMinutes.description)
                        Text("min.")
                    }
                }
//            }
        }
    }
}

#Preview {
    return TaskCardView(task: Project.sampleProjects[0].tasks[0], isSubGroup: true)
}
