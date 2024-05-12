//
//  ProjectsTask.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import Foundation
import SwiftData

@Model
class ProjectsTask {
    @Attribute(.unique) var id: UUID
    var project: Project?
    var parentTask: ProjectsTask?
    var taskIsCompleted: Bool
    var taskName: String
    var taskDescryption: String
    var priority: Priority
    var estimatedImplTimeMinutes: Int
    var realImplTimeMinutes: Int
    var creationDate: Date
    var dueDate: Date
    @Relationship(deleteRule: .cascade, inverse: \ProjectsTask.parentTask) var subTask: [ProjectsTask]
    var subTaskUnfold: Bool
    @Relationship(deleteRule: .cascade, inverse: \TasksNote.task) var notes: [TasksNote]
    var tasksCount: Int
    var tasksCompleted: Int
    
    init(id: UUID = UUID(), project: Project? = nil, isCompleted: Bool, name: String, description: String, priority: Priority, estimatedImplTimeMinutes: Int, realImplTimeMinutes: Int, creationDate: Date, dueDate: Date, subTask: [ProjectsTask] = [], subTaskUnfold: Bool, notes: [TasksNote] = []) {
        self.id = id
        self.project = project
        self.taskIsCompleted = false
        self.taskName = name
        self.taskDescryption = description
        self.priority = priority
        self.estimatedImplTimeMinutes = estimatedImplTimeMinutes
        self.realImplTimeMinutes = realImplTimeMinutes
        self.creationDate = creationDate
        self.dueDate = dueDate
        self.subTask = subTask
        self.subTaskUnfold = false
        self.notes = notes
        self.tasksCount = 0
        self.tasksCompleted = 0
        updateStats()
    }
    
    func updateStats(){
        if !subTask.isEmpty {
            tasksCount = 0
            tasksCompleted = 0
            realImplTimeMinutes = 0
            countTasks(subTask)
        }
    }
    
    func countTasks(_ projectTasks: [ProjectsTask]) -> () {
        for ta in projectTasks{
            if !ta.subTask.isEmpty{
                countTasks(ta.subTask)
            } else {
                tasksCount += 1
                realImplTimeMinutes += ta.realImplTimeMinutes
                if ta.taskIsCompleted {
                    tasksCompleted += 1
                }
            }
        }
    }
    
    func copyTask (to: ProjectsTask) -> () {
//        to.project = project          ---> to be confirmed if after editing task no unassigned task is saved in the file
//        to.parentTask = parentTask
        
        to.taskIsCompleted = taskIsCompleted
        to.taskName = taskName
        to.taskDescryption = taskDescryption
        to.priority = priority
        to.estimatedImplTimeMinutes = estimatedImplTimeMinutes
        to.realImplTimeMinutes = realImplTimeMinutes
        to.creationDate = creationDate
        to.dueDate = dueDate
    }
    
    static var emptyTask: ProjectsTask{
        ProjectsTask(isCompleted: false, name: "", description: "", priority: .dontCare, estimatedImplTimeMinutes: 0, realImplTimeMinutes: 0, creationDate: Date(), dueDate: Date(), subTask: [], subTaskUnfold: false, notes: [])
    }
}
