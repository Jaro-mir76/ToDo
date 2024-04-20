//
//  Project.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 28/10/2023.
//

import Foundation

struct Project: Identifiable{
    let id: UUID
    //var subProject: Bool
    var name: String
    var description: String
    var priority: Priority
    var dueDate: Date
    var isCompleted: Bool
    var tasks: [ProjectsTask]
    var theme: Theme
    
    func tasksOpened() -> Int {
        //var tasks = tasks
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
        //var tasks = subTask
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
    
    init(id: UUID = UUID(), name: String, description: String, priority: Priority, dueDate: Date, isCompleted: Bool, tasks: [ProjectsTask], theme: Theme) {
        self.id = id
        //self.subProject = subProject
        self.name = name
        self.description = description
        self.priority = priority
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.tasks = tasks
        self.theme = theme
    }
}

extension Project {
    static var emptyProject: Project{
        Project(name: "", description: "", priority: .dontCare, dueDate: Date(), isCompleted: false, tasks: [], theme: .blue)
    }
    
    static let sampleProjects: [Project] =
    [
        Project(name: "Wagoniki",
                description: "Tworzenie iOS aplikacji pomagającej w efektywnym wykonywaniu zadań.",
                priority: .high,
                dueDate: Date(),
                isCompleted: false,
                tasks: [
                    ProjectsTask(isCompleted: false,
                                name: "Zdobyć wiedzę teoretyczną",
                                description: "Przestudiować materiały ze strony dla Swift developerów",
                                priority: .critical,
                                estimatedImplTimeMinutes: 1200,
                                realImplTimeMinutes: 0,
                                dueDate: Date(timeIntervalSinceNow: 0),
                                isSubtask: false,
                                subTask: [],
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
        Project(name: "Codzienne obowiązki",
                description: "List zadań wykonywanych codziennie.",
                priority: .medium,
                dueDate: Date(),
                isCompleted: false,
                tasks: [
                    ProjectsTask(
                                 isCompleted: false,
                                 name: "Raport PW2",
                                 description: "",
                                 priority: .medium,
                                 estimatedImplTimeMinutes: 60,
                                 realImplTimeMinutes: 0,
                                 dueDate: Date(timeIntervalSinceNow: 0),
                                 isSubtask: false,
                                 subTask: [],
                                 notes: []
                                ),
                    ProjectsTask(
                                 isCompleted: true,
                                 name: "Sprawdzić nowy wniosek",
                                 description: "Sprawdzić wiosek o przygotowanie projektu",
                                 priority: .medium,
                                 estimatedImplTimeMinutes: 30,
                                 realImplTimeMinutes: 0,
                                 dueDate: Date(timeIntervalSinceNow: 0),
                                 isSubtask: false,
                                 subTask: [],
                                 notes: []
                                ),
                    ProjectsTask(
                                 isCompleted: false,
                                 name: "Pod projekt",
                                 description: "Co zrobic żeby pogadać z szefem o nowym zadaniu",
                                 priority: .medium,
                                 estimatedImplTimeMinutes: 45,
                                 realImplTimeMinutes: 0,
                                 dueDate: Date(timeIntervalSinceNow: 0),
                                 isSubtask: true,
                                 subTask: [
                                    ProjectsTask(
                                                  isCompleted: false,
                                                  name: "Pod zadanie 1",
                                                  description: "Część większego projektu",
                                                  priority: .medium,
                                                  estimatedImplTimeMinutes: 60,
                                                  realImplTimeMinutes: 0,
                                                  dueDate: Date(timeIntervalSinceNow: 0),
                                                  isSubtask: false,
                                                  subTask: [],
                                                  notes: []
                                                 ),
                                     ProjectsTask(
                                                  isCompleted: false,
                                                  name: "Pod zadanie 2",
                                                  description: "Podzadanie z większego projektu",
                                                  priority: .medium,
                                                  estimatedImplTimeMinutes: 30,
                                                  realImplTimeMinutes: 0,
                                                  dueDate: Date(timeIntervalSinceNow: 0),
                                                  isSubtask: false,
                                                  subTask: [],
                                                  notes: []
                                                 )
                                 ],
                                 notes: []
                                ),
                    ProjectsTask(
                                 isCompleted: true,
                                 name: "Z3",
                                 description: "Zadanie główne 3ie",
                                 priority: .medium,
                                 estimatedImplTimeMinutes: 30,
                                 realImplTimeMinutes: 0,
                                 dueDate: Date(timeIntervalSinceNow: 0),
                                 isSubtask: false,
                                 subTask: [],
                                 notes: []
                                )
                    ],
                theme: .yellow
        )
    ]
}
