//
//  TaskStatusButton.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 09/11/2023.
//

import SwiftUI

struct TaskStatusButton: View {
    @Binding var isCompleted: Bool
    
    var body: some View {
        Button{
            isCompleted.toggle()
        } label: {
            Label("Toggle task status", systemImage: isCompleted ? "checkmark.square" : "square")
                .labelStyle(.iconOnly)
        }
    }
}

#Preview {
    return TaskStatusButton(isCompleted: .constant(true))
}
