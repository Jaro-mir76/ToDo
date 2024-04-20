//
//  ProjectsTask.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import Foundation

struct ProjectsTask: Identifiable {
    var id: UUID
    var isCompleted: Bool
    var name: String
    var description: String
    var priority: Priority
    var estimatedImplTimeMinutes: Int
    var realImplTimeMinutes: Int
    var dueDate: Date
    var isSubtask: Bool
    var subTask: [ProjectsTask]
    var notes: [TasksNote]
    
    func tasksOpened() -> Int {
        var tasks = subTask
        var countTasksOpened: Int = 0
        for ta in tasks {
            if !ta.subTask.isEmpty {
                tasksOpened(t: ta.subTask)
            } else if !ta.isCompleted{
                countTasksOpened += 1
            }
        }
        func tasksOpened(t: [ProjectsTask]){
            for ta in t {
                if !ta.subTask.isEmpty {
                    tasksOpened(t: ta.subTask)
                } else if !ta.isCompleted{
                    countTasksOpened += 1
                }
            }
            return
        }
        return countTasksOpened
    }
    
    func tasksClosed() -> Int {
        var tasks = subTask
        var countTasksClosed: Int = 0
        for ta in tasks {
            if !ta.subTask.isEmpty {
                tasksOpened(t: ta.subTask)
            } else if ta.isCompleted{
                countTasksClosed += 1
            }
        }
        func tasksOpened(t: [ProjectsTask]){
            for ta in t {
                if !ta.subTask.isEmpty {
                    tasksOpened(t: ta.subTask)
                } else if ta.isCompleted{
                    countTasksClosed += 1
                }
            }
            return
        }
        return countTasksClosed
    }
    
    init(id: UUID = UUID(), isCompleted: Bool, name: String, description: String, priority: Priority, estimatedImplTimeMinutes: Int, realImplTimeMinutes: Int, dueDate: Date, isSubtask: Bool, subTask: [ProjectsTask], notes: [TasksNote]) {
        self.id = id
        self.isCompleted = isCompleted
        self.name = name
        self.description = description
        self.priority = priority
        self.estimatedImplTimeMinutes = estimatedImplTimeMinutes
        self.realImplTimeMinutes = realImplTimeMinutes
        self.dueDate = dueDate
        self.isSubtask = isSubtask
        self.subTask = subTask
        self.notes = notes
    }
    
    static var emptyTask: ProjectsTask{
        ProjectsTask(isCompleted: false, name: "", description: "", priority: .dontCare, estimatedImplTimeMinutes: 0, realImplTimeMinutes: 0, dueDate: Date(), isSubtask: false, subTask: [], notes: [])
    }
}
