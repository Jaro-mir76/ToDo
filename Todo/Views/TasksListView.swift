//
//  TasksListView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 10/12/2023.
//

import SwiftUI

struct TasksListView: View {
    //@Binding var project: Project
    @Binding var tasks: [ProjectsTask]
    var isSubGroup: Bool
    @State var SubGroupOpened: Bool = false
    
    var body: some View {
        ForEach($tasks){ $task in
            if !task.subTask.isEmpty {
                HStack {
                    SubListUnfold(unFold: $SubGroupOpened)
                    VStack {
                        VStack (alignment: .leading){
                                NavigationLink(destination: TasksDetailsView(task: $task)){
                                    TaskCardView(task: $task, isSubGroup: isSubGroup)
                                }
                        }
                    }
                }
                if SubGroupOpened {
                    //VStack {
                        TasksListView(tasks: $task.subTask, isSubGroup: true)
                        .padding(.leading, 30)
                    //}
                    //.padding(.leading, 30)
                }
            } else {
                NavigationLink(destination: TasksDetailsView(task: $task)){
                    TaskCardView(task: $task, isSubGroup: isSubGroup)
                }
            }
        }
    }
}

#Preview {
    TasksListView(tasks: .constant(Project.sampleProjects[1].tasks), isSubGroup: true)
}
