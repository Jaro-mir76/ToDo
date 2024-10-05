//
//  CommentsCardView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 02/11/2023.
//

import SwiftUI
import SwiftData

struct NotesCardView: View {
    let notes: TaskNote
    
    var body: some View {
        VStack (alignment: .leading){
            Text(notes.note)
            HStack{
                Spacer()
                Text(notes.author?.name ?? "Anonymous")
            }
        }
    }
}

#Preview(traits: .modelContainerSampleData) {
    NotesCardView(notes: Project.sampleProjects[0].tasks[0].notes[0])
}
