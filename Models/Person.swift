//
//  Person.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import Foundation
import SwiftData

@Model
class Person {
    @Attribute(.unique) var id: UUID
    var name: String
    @Relationship(inverse: \TaskNote.author) var tasks: [TaskNote]
    
    init(id: UUID = UUID(), name: String, tasks: [TaskNote] = []) {
        self.id = id
        self.name = name
        self.tasks = tasks
    }
    
    @MainActor
    func insertExamplesIntoContext (in context: ModelContainer){
        context.mainContext.insert(Person(name: "Anonimous"))
    }
}
