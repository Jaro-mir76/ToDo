//
//  PriorityPicker.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 06/11/2023.
//

import SwiftUI

struct PriorityPicker: View {
    @Binding var selection: Priority

        var body: some View {
            Picker("", selection: $selection) {
                ForEach(Priority.allCases) { priority in
                    PriorityView(priority: priority)
                        .tag(priority)
                }
            }
            .pickerStyle(.menu)
        }
    }

#Preview {
    return PriorityPicker(selection: .constant(.dontCare))
}
