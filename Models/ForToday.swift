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
    @Attribute(.unique) var id: UUID
    var today: Date
    var task: ProjectTask?
    
    init(id: UUID = UUID(), today: Date, task: ProjectTask? = nil) {
        self.id = id
        self.today = today
        self.task = task
    }
    
    @MainActor
    func insertExamplesIntoContext (in context: ModelContainer){
        context.mainContext.insert(ForToday(today: Date()))
    }
}
