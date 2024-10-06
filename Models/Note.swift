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
    var text: String
    
    init(id: UUID = UUID(), text: String) {
        self.id = id
        self.text = text
    }
    
    @MainActor
    func insertExamplesIntoContext (in context: ModelContainer){
        context.mainContext.insert(Note(text: "Short note"))
        context.mainContext.insert(Note(text: "a little bit longer note because I have so much in my head and have to write it down somewhere"))
    }
}
