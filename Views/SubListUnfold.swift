//
//  SubListUnfold.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 23/01/2024.
//

import SwiftUI

struct SubListUnfold: View {
    @Binding var unFold: Bool
    
    var body: some View {
        Button{
            unFold.toggle()
        } label: {
            Label("", systemImage: unFold ? "chevron.down" : "chevron.right")
                .font(.caption2)
        }
        //.padding([.leading, .trailing], -11)
        .padding(EdgeInsets(top: 0, leading: -8, bottom: 0, trailing: -14))
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SubListUnfold(unFold: .constant(true))
}
