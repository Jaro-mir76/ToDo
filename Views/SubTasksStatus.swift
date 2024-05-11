//
//  SubTasksStatus.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 06/05/2024.
//

import SwiftUI

struct SubTasksStatus: View {
    var task: ProjectsTask
    
    var body: some View {
        Text("\(task.tasksCompleted)/\(task.tasksCount)")
    }
}

#Preview {
    return SubTasksStatus(task: ProjectsTask.emptyTask)
}
