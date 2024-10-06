//
//  Project.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 28/10/2023.
//

import Foundation
import SwiftData

@Model
class Project {
    @Attribute(.unique) var id: UUID
    var projName: String
    var projDescription: String
    var priority: Priority
    var dueDate: Date
    var isCompleted: isCompleted
    @Relationship(deleteRule: .cascade, inverse: \ProjectTask.project) var tasks: [ProjectTask]
    var theme: Theme
    var tasksCount: Int
    var tasksCompleted: Int
    
    init(id: UUID = UUID(), projName: String = "", projDescription: String = "", priority: Priority, dueDate: Date, isCompleted: isCompleted, tasks: [ProjectTask] = [], theme: Theme) {
        self.id = id
        self.projName = projName
        self.projDescription = projDescription
        self.priority = priority
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.tasks = tasks
        self.theme = theme
        self.tasksCount = 0
        self.tasksCompleted = 0
        updateStats()
    }
    
    func updateStats(){
        tasksCount = 0
        tasksCompleted = 0
        if !tasks.isEmpty {
            countTasks(tasks.filter({$0.parentTask == nil}))
        }
    }
    
    func countTasks(_ projectTasks: [ProjectTask]) -> () {
        for ta in projectTasks{
            if !ta.subTask.isEmpty{
                ta.updateStats()
                countTasks(ta.subTask)
            } else {
                tasksCount += 1
                if ta.taskIsCompleted {
                    tasksCompleted += 1
                }
            }
        }
    }
    
    func copyProject (to: Project) -> () {
        to.projName = projName
        to.projDescription = projDescription
        to.priority = priority
        to.dueDate = dueDate
        to.isCompleted = isCompleted
        to.theme = theme
//        to.tasks = tasks          =---> why copy of tasks cause that during editing of project copy of project is added to projects
    }
    
    @MainActor
    func insertExamplesIntoContext (in context: ModelContainer){
        context.mainContext.insert(Project.sampleProjects[0])
        context.mainContext.insert(Project.sampleProjects[1])
    }
    
}

extension Project {
    static var emptyProject: Project{
        Project(projName: "", projDescription: "", priority: .medium, dueDate: Date(), isCompleted: .notCompleted, tasks: [], theme: .green)
    }
    
    static let sampleProjects: [Project] = [
        Project(projName: "Project ToDo app",
            projDescription: "Creation of application for tasks management.",
            priority: .high,
            dueDate: Date(),
            isCompleted: .notCompleted,
            tasks: [
                ProjectTask(isCompleted: false,
                            name: "Gather theoretical knowledge",
                            description: "Study materials on apple page for developers",
                            priority: .critical,
                            estimatedImplTimeMinutes: 1200,
                            realImplTimeMinutes: 0,
                            creationDate: Date(timeIntervalSinceNow: 0),
                            dueDate: Date(timeIntervalSinceNow: 0),
                            //isSubtask: false,
                            subTask: [],
                            subTaskUnfold: false,
                            notes: [
                                        TaskNote(note: "I face some problems, materials on web are a bit outdated",
                                                author: Person(name: "Adam")
                                               ),
                                        TaskNote(note: "...slowely going there",
                                                author: Person(name: "Adam")
                                               ),
                                        TaskNote(note: "hmmm.....",
                                                author: Person(name: "Adam")
                                               ),
                                        TaskNote(note: ":-D",
                                                author: Person(name: "Adam")
                                               )
                                ]
                            
                            ),
                ProjectTask(isCompleted: false,
                            name: "Learn by doing",
                            description: "Find a good idea for a project and do it",
                            priority: .critical,
                            estimatedImplTimeMinutes: 200,
                            realImplTimeMinutes: 0,
                            creationDate: Date(timeIntervalSinceNow: 0),
                            dueDate: Date(timeIntervalSinceNow: 0),
                            //isSubtask: false,
                            subTask: [],
                            subTaskUnfold: false,
                            notes: [ TaskNote(note: "...still thinking",
                                        author: Person(name: "Adam")
                                        )
                                ]
                            
                            )
                ],
            theme: .blue
           ),
        Project(projName: "Shopping",
            projDescription: "Buy food for lunch.",
            priority: .high,
            dueDate: Date(),
            isCompleted: .notCompleted,
            tasks: [
                ProjectTask(isCompleted: false,
                            name: "Shopping list",
                            description: "Ask team for recomendations",
                            priority: .medium,
                            estimatedImplTimeMinutes: 1200,
                            realImplTimeMinutes: 0,
                            creationDate: Date(timeIntervalSinceNow: 0),
                            dueDate: Date(timeIntervalSinceNow: 0),
                            //isSubtask: false,
                            subTask: [],
                            subTaskUnfold: false,
                            notes: [
                                        TaskNote(note: "Don't ask boss",
                                                author: Person(name: "Adam")
                                               ),
                                        TaskNote(note: "...too late",
                                                author: Person(name: "Adam")
                                               )
                                ]
                            
                            )
                ],
                theme: .mint
           )
    ]
}
