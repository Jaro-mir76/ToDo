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
    var body: some View {
        List{
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
                    VStack(alignment: .leading){
                        Text("\(task.taskName)")
                        Spacer()
                        Text("\(task.projectName)")
                            .font(.footnote)
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
                }
            }
        }
    }
}

#Preview {
    ForTodayView()
}
