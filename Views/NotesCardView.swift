//
//  CommentsCardView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 02/11/2023.
//

import SwiftUI

struct NotesCardView: View {
    let notes: TaskNote
    
    var body: some View {
        VStack (alignment: .leading){
            Text(notes.note)
            HStack{
                Spacer()
                Text(notes.author.name)
            }
        }
    }
}

#Preview {
    return NotesCardView(notes: Project.sampleProjects[0].tasks[0].notes[0])
}
