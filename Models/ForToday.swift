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
    @Attribute(.unique) let id: UUID
    var today: Date
    var task: ProjectTask
//    var taskId: UUID
//    var taskName: String
//    var projectName: String
    
    init(id: UUID = UUID(), today: Date, task: ProjectTask) {
        self.id = id
        self.today = today
        self.task = task
//        self.taskId = taskId
//        self.taskName = taskName
//        self.projectName = projName
    }
    
//    func numberOfTasksForToday () -> Int{
//        return tasksForToday.count
//    }
//    
//    func addToList(_ projectTask: ProjectTask) -> (){
//        tasksForToday.append(projectTask)
//    }
//    
//    func removeFromList (_ projectTask: ProjectTask) -> (){
//        tasksForToday.removeAll(where: {$0.id == projectTask.id } )
//    }
}
