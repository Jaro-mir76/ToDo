//
//  PreviewSampleData.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 17/02/2024.
//

import SwiftData
import Foundation
import SwiftUI

struct ModelContainerSampleData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Project.self, ProjectTask.self, TaskNote.self, ForToday.self, Person.self, Note.self,
            configurations: config)
        
        let project = Project(priority: .critical, dueDate: Date(), isCompleted: .completed, theme: .blue)
        project.insertExamplesIntoContext(in: container)
        
        let task = ProjectTask(isCompleted: true, name: "", description: "", priority: .high, estimatedImplTimeMinutes: 10, realImplTimeMinutes: 0, creationDate: Date(), dueDate: Date(), subTaskUnfold: false)
        task.insertExamplesIntoContext(in: container)
        
        let taskNote = TaskNote(note: "")
        taskNote.insertExamplesIntoContext(in: container)
        
        let forToday = ForToday(today: Date())
        forToday.insertExamplesIntoContext(in: container)
        
        let person = Person(name: "")
        person.insertExamplesIntoContext(in: container)
        
        let note = Note(text: "")
        note.insertExamplesIntoContext(in: container)
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @available(iOS 18.0, *)
    @MainActor static var modelContainerSampleData: Self = .modifier(ModelContainerSampleData())
}
