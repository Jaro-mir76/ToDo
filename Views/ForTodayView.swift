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
                ForEach(forToday){task in
//                    NavigationLink(value: task){
                        VStack(alignment: .leading){
                            Button {
                                
                                stateManager.navigationPath.append(task)
                                stateManager.selectedTab = 1
                            }
                            label: {
                                Text("\(task.task.taskName)")
                                Spacer()
                                Text("\(task.task.project!.projName)")
                                    .font(.footnote)
                            }
                            
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false){
                            Button(role: .destructive) {
                                if let context = task.modelContext {
                                    context.delete(task)
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

#Preview {
    ForTodayView()
}
