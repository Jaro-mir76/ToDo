//
//  ForTodayView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 19/06/2024.
//

import SwiftUI
import SwiftData

struct ForTodayView: View {
    @Query private var forToday: [ForToday]
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        NavigationStack(path: $stateManager.navigationPathTab2){
            List {
                Section(){
                    ForEach(forToday){task4today in
                        if let projectColor = task4today.task?.project?.theme.mainColor {
                            @Bindable var task = task4today.task!
//                            NavigationLink(value: task4today.task){
                            NavigationLink(value: task){
                                HStack{
                                    VStack(alignment: .leading){
                                        HStack{
                                            if !task.subTask.isEmpty {
                                                SubTasksStatus(task: task)
                                            } else {
                                                TaskStatusButton(isCompleted: $task.taskIsCompleted)
                                            }
                                            Text(task.taskName)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                            Spacer()
                                        }
//                                        Spacer()
                                        HStack{
                                            Text("Project")
                                                .font(.caption2)
                                            Text(task4today.task!.project!.projName)
                                                .font(.callout)
                                            Spacer()
                                        }
                                        HStack {
                                            Label("", systemImage: "figure.walk.motion")
                                            Text(task.priority.rawValue)
                                            Spacer()
                                            Label("", systemImage: "flag.checkered")
                                            Text(task.estimatedImplTimeString)
                                        }
                                    }
                                }
                            }
                            .listRowBackground(projectColor)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false){
                                Button(role: .destructive) {
                                    if let context = task4today.modelContext {
                                        context.delete(task4today)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Today")
            .navigationDestination(for: ProjectTask.self){ pTask in
                TasksDetailsView(task: pTask)
            }
        }
    }
}

#Preview(traits: .modelContainerSampleData) {
    @Previewable @Query var forToday: [ForToday]
    ForTodayView()
        .environmentObject(StateManager())
}
