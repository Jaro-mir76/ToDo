//
//  TaskCardView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 01/11/2023.
//

import SwiftUI

struct TaskCardView: View {
    @Bindable var task: ProjectTask
    var isSubGroup: Bool = false
    
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                if !task.subTask.isEmpty {
                    SubListUnfold(unFold: $task.subTaskUnfold)
                }
                VStack{
                    HStack{
                        if !task.subTask.isEmpty {
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
                        VStack(alignment: .leading){
                            HStack {
                                Label("", systemImage: "figure.walk.motion")
                                Text(task.priority.rawValue)
                            }
                            HStack {
                                Label("", systemImage: "stopwatch")
                                TimeDurationView(duration: task.realImplTimeMinutes)
                            }
                        }
                        Spacer()
                        VStack (alignment: .leading) {
                            HStack {
                                Label("", systemImage: "calendar")
                                Text(task.dueDate.formatted(date: .numeric, time: .omitted))
                            }
                            HStack {
                                Label("", systemImage: "flag.checkered")
                                Text(task.estimatedImplTimeString)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview(traits: .modelContainerSampleData) {
    return TaskCardView(task: Project.sampleProjects[0].tasks[0], isSubGroup: true)
}
