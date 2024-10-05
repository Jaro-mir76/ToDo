//
//  ForToday.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 19/06/2024.
//

import Foundation
import SwiftData

@Model
class ForToday {
    @Attribute(.unique) var id: UUID
    var today: Date
    var task: ProjectTask?
    
    init(id: UUID = UUID(), today: Date, task: ProjectTask? = nil) {
        self.id = id
        self.today = today
        self.task = task
    }
    
    @MainActor
    func insertExamplesIntoContext (in context: ModelContainer){
        context.mainContext.insert(ForToday(today: Date(), task: ProjectTask(project: Project.sampleProjects[0], isCompleted: true, name: "TASK ONE", description: "Task one - description", priority: .critical, estimatedImplTimeMinutes: 10, realImplTimeMinutes: 0, creationDate: Date(), dueDate: Date(), subTaskUnfold: false)))
        context.mainContext.insert(ForToday(today: Date(), task: ProjectTask(project: Project.sampleProjects[1], isCompleted: true, name: "TASK TWO", description: "Task two - description", priority: .critical, estimatedImplTimeMinutes: 10, realImplTimeMinutes: 0, creationDate: Date(), dueDate: Date(), subTaskUnfold: false)))
    }
}




