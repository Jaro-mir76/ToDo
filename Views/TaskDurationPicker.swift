//
//  TaskDurationPicker.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 08/06/2024.
//

import SwiftUI

struct TaskDurationPicker: View {
    @Binding var task: ProjectTask
    @State private var showTimeWheel = false
    
    var body: some View {
        HStack {
            Text("Task Duration")
                .font(.footnote)
                .textCase(.uppercase)
                .foregroundColor(.gray)
            Spacer()
            Text ("\(task.estimatedImplTimeHours < 10 ? "0": "")\(task.estimatedImplTimeHours):\(task.estimatedImplTimeMinutes < 10 ? "0": "" )\(task.estimatedImplTimeMinutes)")
//                .background(.yellow, in: .buttonBorder, fillStyle: .init())
                .foregroundStyle(showTimeWheel ? .red : .black)
                .onTapGesture {
                    withAnimation{
                        showTimeWheel.toggle()
                    }
                }
        }
        if showTimeWheel {
            HStack{
                Picker("Time Wheel Hours", selection: $task.estimatedImplTimeHours) {
                    ForEach(TaskDurationHours.allCases) { taskDuration in
                        HStack(){
                            Spacer()
                            Text("\(taskDuration.rawValue < 10 ? "0": "")\(taskDuration.rawValue)")
                                .tag(taskDuration)
                        }
                    }
                }
                .pickerStyle(.wheel)
                Picker("Time Wheel Minutes", selection: $task.estimatedImplTimeMinutes) {
                    ForEach(TaskDurationMinutes.allCases) { taskDuration in
                        HStack(){
                            Text("\(taskDuration.rawValue < 10 ? "0": "")\(taskDuration.rawValue)")
                                .tag(taskDuration)
                            Spacer()
                        }
                            
                    }
                }
                .pickerStyle(.wheel)
            }
        }
    }
}

#Preview {
    return TaskDurationPicker(task: .constant(Project.sampleProjects[0].tasks[0]))
}
