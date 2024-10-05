//
//  SubTasksStatus.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 06/05/2024.
//

import SwiftUI

struct SubTasksStatus: View {
    var task: ProjectTask
    
    var body: some View {
        Text("\(task.tasksCompleted)/\(task.tasksCount)")
    }
}

#Preview(traits: .modelContainerSampleData) {
    return SubTasksStatus(task: Project.sampleProjects[0].tasks[0])
}
