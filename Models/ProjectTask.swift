//
//  ProjectsTask.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import Foundation
import SwiftData

@Model
class ProjectTask {
    @Attribute(.unique) var id: UUID
    var project: Project?
    var parentTask: ProjectTask?
    var taskIsCompleted: Bool
    var taskName: String
    var taskDescryption: String
    var priority: Priority
    var estimatedImplTime: Int // in minutes
    var estimatedImplTimeMinutes: Int {
        get {
            return estimatedImplTime % 60
        }
        set {
            estimatedImplTime = (estimatedImplTime - (estimatedImplTime % 60)) + newValue
        }
    }
    var estimatedImplTimeHours: Int {
        get {
            return (estimatedImplTime - (estimatedImplTime % 60)) / 60
        }
        set {
            estimatedImplTime = newValue * 60 + (estimatedImplTime % 60)
        }
    }
    var estimatedImplTimeString: String { // estimated implementation time in form HH:MM
        return "\(estimatedImplTimeHours < 10 ? "0" : "")\(estimatedImplTimeHours):\(estimatedImplTimeMinutes < 10 ? "0": "")\(estimatedImplTimeMinutes)"
    }
    var realImplTimeMinutes: Int
    var creationDate: Date
    var dueDate: Date
    @Relationship(deleteRule: .cascade, inverse: \ProjectTask.parentTask) var subTask: [ProjectTask]
    var subTaskUnfold: Bool
    @Relationship(deleteRule: .cascade, inverse: \TaskNote.task) var notes: [TaskNote]
    var tasksCount: Int
    var tasksCompleted: Int
    @Relationship(deleteRule: .cascade, inverse: \ForToday.task) var forToday: ForToday?
    
    init(id: UUID = UUID(), project: Project? = nil, isCompleted: Bool, name: String, description: String, priority: Priority, estimatedImplTimeMinutes: Int, realImplTimeMinutes: Int, creationDate: Date, dueDate: Date, subTask: [ProjectTask] = [], subTaskUnfold: Bool, notes: [TaskNote] = [], forToday: ForToday? = nil) {
        self.id = id
        self.project = project
        self.taskIsCompleted = false
        self.taskName = name
        self.taskDescryption = description
        self.priority = priority
        self.estimatedImplTime = estimatedImplTimeMinutes
        self.realImplTimeMinutes = realImplTimeMinutes
        self.creationDate = creationDate
        self.dueDate = dueDate
        self.subTask = subTask
        self.subTaskUnfold = false
        self.notes = notes
        self.tasksCount = 0
        self.tasksCompleted = 0
        self.forToday = forToday
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
    
    func countTasks(_ projectTasks: [ProjectTask]) -> () {
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
    
    func copyTask (to: ProjectTask) -> () {
//        to.project = project          ---> to be confirmed if after editing task no unassigned task is saved in the file
//        to.parentTask = parentTask
        
        to.taskIsCompleted = taskIsCompleted
        to.taskName = taskName
        to.taskDescryption = taskDescryption
        to.priority = priority
        to.estimatedImplTime = estimatedImplTime
        to.realImplTimeMinutes = realImplTimeMinutes
        to.creationDate = creationDate
        to.dueDate = dueDate
    }
    
    static var emptyTask: ProjectTask{
        ProjectTask(isCompleted: false, name: "", description: "", priority: .medium, estimatedImplTimeMinutes: 0, realImplTimeMinutes: 0, creationDate: Date(), dueDate: Date(), subTask: [], subTaskUnfold: false, notes: [])
    }
    
    @MainActor
    func insertExamplesIntoContext (in context: ModelContainer){
        context.mainContext.insert(ProjectTask(isCompleted: true, name: "TASK ONE", description: "Task one - description", priority: .critical, estimatedImplTimeMinutes: 10, realImplTimeMinutes: 0, creationDate: Date(), dueDate: Date(), subTaskUnfold: false))
    }
}
