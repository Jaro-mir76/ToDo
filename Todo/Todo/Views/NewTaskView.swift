//
//  NewTaskView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 09/11/2023.
//

import SwiftUI

struct NewTaskView: View {
    @State private var newtask = ProjectsTask.emptyTask
    @Binding var tasks: [ProjectsTask]
    @Binding var isPresentingNewTask: Bool
    
    var body: some View {
        NavigationStack{
            TasksEditView(task: $newtask)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel"){
                            isPresentingNewTask = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Add"){
                            tasks.append(newtask)
                            isPresentingNewTask = false
                        }
                    }
                }
        }
    }
}

#Preview {
    return NewTaskView(tasks: .constant(Project.sampleProjects[0].tasks), isPresentingNewTask: .constant(true))
}
