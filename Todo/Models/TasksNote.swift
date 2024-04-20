//
//  Comment.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import Foundation

struct TasksNote: Identifiable {
    let id: UUID
    var note: String
    var author: Person
    
    init(id: UUID = UUID(), note: String, author: Person) {
        self.id = id
        self.note = note
        self.author = author
    }
}
