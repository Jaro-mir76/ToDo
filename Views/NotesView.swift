//
//  NotesView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 05/10/2024.
//

import SwiftUI
import SwiftData

struct NotesView: View {
    @Query(sort: [SortDescriptor(\Note.creationDate)])
    private var notes: [Note]
//    @State private var note2Task: String = ""
    @State private var newNote: String = ""
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        NavigationStack {
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
                        Section(header: Text("Notes")){
                            ForEach(notes) { note in
                                    Text(note.text)
                                .swipeActions(edge: .leading, allowsFullSwipe: false){
                                    Button {    // swipe action to convert note to project task
                                        stateManager.isPresentingNote2ProjectPhase1 = true
                                        stateManager.note2Transfer = note
                                    } label: {
                                        Label("Add to Project", systemImage: "pencil.and.list.clipboard")
                                    }
                                    .tint(.green)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false){
                                    Button(role: .destructive) {    // swipe to delete note
                                        withAnimation {
                                            if let context = note.modelContext {
                                                context.delete(note)
                                            }
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                }
                            }
                        }
                    }
            }
            .navigationTitle("Notes")
            .sheet(isPresented: $stateManager.isPresentingNote2ProjectPhase1){
                NavigationStack{
                    ProjectTaskSelectionView(note: stateManager.note2Transfer!.text)
                    .navigationTitle(Text("Choose Project/task"))
                    .toolbar {
                    }
                }
            }
        }
    }
}

#Preview(traits: .modelContainerSampleData) {
    @Previewable @Query var notes: [Note]
    NotesView()
        .environmentObject(StateManager())
}
