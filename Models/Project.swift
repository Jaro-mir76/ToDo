//
//  Project.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 28/10/2023.
//

import Foundation
import SwiftData

@Model
class Project {
    @Attribute(.unique) let id: UUID
    var projName: String
    var projDescription: String
    var priority: Priority
    var dueDate: Date
    var isCompleted: isCompleted
    @Relationship(deleteRule: .cascade, inverse: \ProjectsTask.project) var tasks: [ProjectsTask]
    var theme: Theme
    var tasksCount: Int
    var tasksCompleted: Int
    
    init(id: UUID = UUID(), projName: String, projDescription: String, priority: Priority, dueDate: Date, isCompleted: isCompleted, tasks: [ProjectsTask] = [], theme: Theme) {
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
    
    func countTasks(_ projectTasks: [ProjectsTask]) -> () {
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
}

extension Project {
    static var emptyProject: Project{
        Project(projName: "", projDescription: "", priority: .dontCare, dueDate: Date(), isCompleted: .notCompleted, tasks: [], theme: .blue)
    }
    
    static let sampleProjects: [Project] =
    [
        Project(projName: "Wagoniki",
                projDescription: "Tworzenie iOS aplikacji pomagającej w efektywnym wykonywaniu zadań.",
                priority: .high,
                dueDate: Date(),
                isCompleted: .notCompleted,
                tasks: [
                    ProjectsTask(isCompleted: false,
                                name: "Zdobyć wiedzę teoretyczną",
                                description: "Przestudiować materiały ze strony dla Swift developerów",
                                priority: .critical,
                                estimatedImplTimeMinutes: 1200,
                                realImplTimeMinutes: 0,
                                creationDate: Date(timeIntervalSinceNow: 0),
                                dueDate: Date(timeIntervalSinceNow: 0),
                                //isSubtask: false,
                                subTask: [],
                                subTaskUnfold: false,
                                notes: [
                                            TasksNote(note: "Są pewne problemy z materiałami dlatego że w najnowszej wersji Swift'a są zmiany",
                                                    author: Person(name: "Adam")
                                                   ),
                                            TasksNote(note: "...ale jakoś powoli dajemy rade",
                                                    author: Person(name: "Adam")
                                                   )
                                    ]
                                )
                    ],
                theme: .blue
               ),
        Project(projName: "Codzienne obowiązki",
                projDescription: "List zadań wykonywanych codziennie.",
                priority: .medium,
                dueDate: Date(),
                isCompleted: .notCompleted,
                tasks: [
                    ProjectsTask(
                        isCompleted: false,
                                 name: "Raport PW2",
                                 description: "",
                                 priority: .medium,
                                 estimatedImplTimeMinutes: 60,
                                 realImplTimeMinutes: 0,
                                creationDate: Date(timeIntervalSinceNow: 0),
                                 dueDate: Date(timeIntervalSinceNow: 0),
                                 //isSubtask: false,
                                 subTask: [],
                                 subTaskUnfold: false,
                                 notes: []
                                ),
                    ProjectsTask(
                        isCompleted: false,
                                 name: "Sprawdzić nowy wniosek",
                                 description: "Sprawdzić wiosek o przygotowanie projektu",
                                 priority: .medium,
                                 estimatedImplTimeMinutes: 30,
                                 realImplTimeMinutes: 0,
                                creationDate: Date(timeIntervalSinceNow: 0),
                                 dueDate: Date(timeIntervalSinceNow: 0),
                                 //isSubtask: false,
                                 subTask: [],
                                 subTaskUnfold: false,
                                 notes: []
                                ),
                    ProjectsTask(
                        isCompleted: false,
                                 name: "Pod projekt",
                                 description: "Co zrobic żeby pogadać z szefem o nowym zadaniu",
                                 priority: .medium,
                                 estimatedImplTimeMinutes: 45,
                                 realImplTimeMinutes: 0,
                                 creationDate: Date(timeIntervalSinceNow: 0),
                                 dueDate: Date(timeIntervalSinceNow: 0),
                                 //isSubtask: true,
                                 subTask: [
                                    ProjectsTask(
                                        isCompleted: false,
                                                  name: "Pod zadanie 1",
                                                  description: "Część większego projektu",
                                                  priority: .medium,
                                                  estimatedImplTimeMinutes: 60,
                                                  realImplTimeMinutes: 0,
                                                creationDate: Date(timeIntervalSinceNow: 0),
                                                  dueDate: Date(timeIntervalSinceNow: 0),
                                                  //isSubtask: false,
                                                  subTask: [],
                                                  subTaskUnfold: false,
                                                  notes: []
                                                 ),
                                     ProjectsTask(
                                                  isCompleted: false,
                                                  name: "Pod zadanie 2",
                                                  description: "Podzadanie z większego projektu",
                                                  priority: .medium,
                                                  estimatedImplTimeMinutes: 30,
                                                  realImplTimeMinutes: 0,
                                                  creationDate: Date(timeIntervalSinceNow: 0),
                                                  dueDate: Date(timeIntervalSinceNow: 0),
                                                  //isSubtask: false,
                                                  subTask: [],
                                                  subTaskUnfold: false,
                                                  notes: []
                                                 )
                                 ],
                                 subTaskUnfold: false,
                                 notes: []
                                ),
                    ProjectsTask(
                        isCompleted: true,
                                 name: "Z3",
                                 description: "Zadanie główne 3ie",
                                 priority: .medium,
                                 estimatedImplTimeMinutes: 30,
                                 realImplTimeMinutes: 0,
                            creationDate: Date(timeIntervalSinceNow: 0),
                                 dueDate: Date(timeIntervalSinceNow: 0),
                                 //isSubtask: false,
                                 subTask: [],
                                subTaskUnfold: false,
                                 notes: []
                                )
                    ],
                theme: .yellow
        )
    ]
}
