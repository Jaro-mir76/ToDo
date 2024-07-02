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
        NavigationStack{
            List {
                Section(header:
                            HStack{
                    Text("Tasks for today").foregroundColor(.black)
                    //                Spacer()
                    //                Button(action: {
                    //                    isPresentingNewTask = true
                    //                }, label: {
                    //                    Label("", systemImage: "plus.circle.fill")
                    //                })
                }
                ){
                    ForEach(forToday){task4today in
                        NavigationLink(value: task4today.task){
                            VStack(alignment: .leading){
                                Text("\(task4today.task!.taskName)")
                                Spacer()
                                Text("\(task4today.task!.project!.projName)")
                                    .font(.footnote)
                            }
                        }
                        .navigationDestination(for: ProjectTask.self){ pTask in
                            TasksDetailsView(task: pTask)
                        }
                        
                        
                        //                        VStack(alignment: .leading){
                        //                            Button {
                        //
                        //                                stateManager.navigationPath.append(task4today.task)
                        //                                stateManager.selectedTab = 1
                        //                            }
                        //                            label: {
                        //                                Text("\(task4today.task!.taskName)")
                        //                                Spacer()
                        //                                Text("\(task4today.task!.project!.projName)")
                        //                                    .font(.footnote)
                        //                            }
                        //
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
                        //                    }
                    }
                    //                .navigationDestination(for: ProjectTask.self){ task in
                    //                        TasksDetailsView(task: task)
                    //                }
                }
            }
        }
    }
}

#Preview {
    ForTodayView()
}
