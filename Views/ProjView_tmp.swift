//
//  ProjView_tmp.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 29/06/2024.
//

import SwiftUI
import SwiftData

struct ProjView_tmp: View {

    @Bindable var task: ProjectTask
//    @State private var editingTask = ProjectTask.emptyTask
//    @State private var isPresentingEdit = false
//    @State var isPresentingNewTask = false
//    @State private var newNote = ""
//    @StateObject var workTime = WorkTime()
//    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        
        HStack{
            if !task.subTask.isEmpty {
                SubTasksStatus(task: task)
            } else {
                TaskStatusButton(isCompleted: $task.taskIsCompleted)
            }
            Text(task.taskName)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Button {
                stateManager.selectedTab = 1
                stateManager.navigationPath = NavigationPath()
                stateManager.navigationPath.append(task.project!)
            }
            label: {
            Text ("Go to Project")
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
        .lineLimit(1)
        
    }
}

#Preview {
    ProjView_tmp(task: (Project.sampleProjects[0].tasks[0]))
}
