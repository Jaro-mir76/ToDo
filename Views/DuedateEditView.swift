//
//  DuedateEditView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 02/06/2024.
//

import SwiftUI

struct DuedateEditView: View {
    @State private var showDatePicker = false
    @Binding var dueDate: Date
    
    var body: some View {
        HStack{
            Text("Due date")
                .font(.footnote)
                .textCase(.uppercase)
                .foregroundColor(.gray)
            Spacer()
            Text(dueDate.formatted(date: .numeric , time: .omitted))
                .foregroundStyle(showDatePicker ? .red : .black)
                .onTapGesture(perform: {
                    withAnimation{
                        showDatePicker.toggle()
                    }
                })
        }
        if showDatePicker {
            DatePicker(
                    "Due Date",
                    selection: $dueDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
        }
    }
}

#Preview {
    return DuedateEditView(dueDate: .constant(Date()))
}
