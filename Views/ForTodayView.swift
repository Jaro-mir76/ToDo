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
                Section(header:
                            HStack{
                                Text("Tasks for today")
                                    .foregroundColor(.black)
                            }
                ){
                    ForEach(forToday){task4today in
                        let projectColor = task4today.task!.project!.theme.mainColor
                        NavigationLink(value: task4today.task){
                            HStack{
                                VStack(alignment: .leading){
                                    Text(task4today.task!.taskName)
                                    Spacer()
                                    Text(task4today.task!.project!.projName)
                                        .font(.footnote)
                               }
                            }
                        }
                        .navigationDestination(for: ProjectTask.self){ pTask in
                            TasksDetailsView(task: pTask)
                        }
                        .listRowBackground(projectColor)
//                        VStack(alignment: .leading){ // this section is to switch tab and display task
//                            Button {
//                                let task = task4today.task
//                                stateManager.selectedTab = 1
//                                stateManager.navigationPath = NavigationPath()
//                                stateManager.navigationPath.append(task!)
//                            }
//                            label: {
//                                Text("\(task4today.task!.taskName)")
//                                Spacer()
//                                Text("\(task4today.task!.project!.projName)")
//                                    .font(.footnote)
//                            }
//                        }
                        
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
    }
}

#Preview {
    ForTodayView()
}
