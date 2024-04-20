//
//  PriorityView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 06/11/2023.
//

import SwiftUI

struct PriorityView: View {
    let priority: Priority
    
    var body: some View {
        Text(priority.rawValue)
            .padding(4)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    return PriorityView(priority: .dontCare)
}
