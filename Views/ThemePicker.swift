//
//  ThemePicker.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 10/11/2023.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    @State private var showThemeWheel: Bool = false
    
    var body: some View {
        HStack {
            Text("Theme")
                .font(.footnote)
                .textCase(.uppercase)
                .foregroundColor(.gray)
            Spacer()
            Text(selection.name)
                .padding(4)
                .frame(maxWidth: .infinity)
                .background(selection.mainColor)
//                .foregroundColor(selection.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .foregroundStyle(showThemeWheel ? .red : selection.accentColor)
                .onTapGesture {
                    withAnimation{
                        showThemeWheel.toggle()
                    }
                }
        }
        if showThemeWheel {
            Picker("", selection: $selection) {
                ForEach(Theme.allCases) { theme in
                    ThemeView(theme: theme)
                        .tag(theme)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

#Preview {
    ThemePicker(selection: .constant(.indigo))
}
