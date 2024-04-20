//
//  TaskCardView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 01/11/2023.
//

import SwiftUI

struct TaskCardView: View {
    @Binding var task: ProjectsTask
    var isSubGroup: Bool
    
    var body: some View {
        VStack (alignment: .leading){
            HStack{
               /* if isSubGroup {
                    Label("", systemImage: "arrow.turn.down.right")
                }*/
                VStack{
                    HStack{
                        if !task.subTask.isEmpty {
                            HStack {
                                Text("\(task.tasksClosed())/\(task.tasksOpened()+task.tasksClosed())")
                                Text(task.name)
                                    .font(.headline)
                                Spacer()
                            }
                        } else {
                            if task.isCompleted == true {
                                Label("", systemImage: "checkmark.square")
                            } else {
                                Label("", systemImage: "square")
                            }
                            Text(task.name)
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
    return TaskCardView(task: .constant(Project.sampleProjects[1].tasks[2]), isSubGroup: true)
}
