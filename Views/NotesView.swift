//
//  NotesView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 05/10/2024.
//

import SwiftUI
import SwiftData

struct NotesView: View {
    @Query private var notes: [Note]
    @State var newNote: String = ""
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Form {
                HStack (alignment: .bottom){
                    TextField("Note...", text: $newNote, axis: .vertical)
                            .lineLimit(3...10)
                    
                        Button(action: {
                            withAnimation {
                                let note = Note(text: newNote)
                                modelContext.insert(note)
                                newNote = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .accessibilityLabel("Add note")
                        }
                        .imageScale(.large)
                        .disabled(newNote.isEmpty)
                }

                if !notes.isEmpty {
                    ForEach(notes) { note in
                        Section{
                            Text(note.text)
                        }
                    }
                }
        }
        
    }
}

#Preview(traits: .modelContainerSampleData) {
    @Previewable @Query var notes: [Note]
    NotesView()
}
