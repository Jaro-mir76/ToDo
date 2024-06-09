//
//  PriorityEditView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 02/06/2024.
//

import SwiftUI

struct PriorityEditView: View {
    @Binding var priority: Priority
    
    var body: some View {
        HStack{
            Text("Priority")
                .font(.footnote)
                .textCase(.uppercase)
                .foregroundColor(.gray)
            Spacer()
            PriorityPicker(selection: $priority)
        }
    }
}

#Preview {
    return PriorityEditView(priority: .constant(Priority.dontCare))
}
