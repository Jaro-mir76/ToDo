//
//  TasksGroup.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 19/11/2023.
//

import Foundation
import SwiftUI

struct TasksGroup: Identifiable{
    let id: UUID
    //var name: String
    //var description: String
    //var priority: Priority
    //var dueDate: Date
    //var isCompleted: Bool
    var tasksGroup: [ProjectsTask]
    //private var countTasksOpened: Int = 0

    /*func tasksOpened() -> Int {
        var tasks = tasksGroup
        var countTasksOpened: Int = 0
        for ta in tasks {
            if !ta.subTask.tasksGroup.isEmpty {
                tasksOpened(t: ta.subTask.tasksGroup)
            } else if !ta.isCompleted{
                countTasksOpened += 1
            }
        }
        func tasksOpened(t: [ProjectsTask]){
            for ta in t {
                if !ta.subTask.tasksGroup.isEmpty {
                    tasksOpened(t: ta.subTask.tasksGroup)
                } else if !ta.isCompleted{
                    countTasksOpened += 1
                }
            }
            return
        }
        return countTasksOpened
    }
    
    func tasksClosed() -> Int {
        var tasks = tasksGroup
        var countTasksClosed: Int = 0
        for ta in tasks {
            if !ta.subTask.tasksGroup.isEmpty {
                tasksOpened(t: ta.subTask.tasksGroup)
            } else if ta.isCompleted{
                countTasksClosed += 1
            }
        }
        func tasksOpened(t: [ProjectsTask]){
            for ta in t {
                if !ta.subTask.tasksGroup.isEmpty {
                    tasksOpened(t: ta.subTask.tasksGroup)
                } else if ta.isCompleted{
                    countTasksClosed += 1
                }
            }
            return
        }
        return countTasksClosed
    }*/
    
    init(id: UUID = UUID(), tasks: [ProjectsTask]) {
        self.id = id
        //self.name = name
        //self.description = description
        //self.priority = priority
        //self.dueDate = dueDate
        //self.isCompleted = isCompleted
        self.tasksGroup = tasks
    }
    
    static var emptyTasksGroup = TasksGroup(tasks: [])
    
}
