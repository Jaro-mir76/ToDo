//
//  Note.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import Foundation
import SwiftData

@Model
class Note{
    @Attribute(.unique) var id: UUID
    var note: String
    var author: Person
    
    init(id: UUID = UUID(), note: String, author: Person) {
        self.id = id
        self.note = note
        self.author = author
    }
    
    @MainActor
    func insertExamplesIntoContext (in context: ModelContainer){
        context.mainContext.insert(Note(note: "Short note", author: Person(name: "Anonimous")))
    }
}
