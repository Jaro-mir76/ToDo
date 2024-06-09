//
//  Comment.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import Foundation
import SwiftData

@Model
class TaskNote {
    @Attribute(.unique) let id: UUID
    var task: ProjectTask?
    var note: String
    var author: Person
    
    init(id: UUID = UUID(), task: ProjectTask? = nil, note: String, author: Person) {
        self.id = id
        self.task = task
        self.note = note
        self.author = author
    }
}
