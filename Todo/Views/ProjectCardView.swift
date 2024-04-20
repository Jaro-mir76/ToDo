//
//  ProjectCardView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import SwiftUI

struct ProjectCardView: View {
    var project: Project
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(project.name)
                .font(.headline)
            Spacer()
            HStack{
                Label("", systemImage: "figure.walk.motion")
                Text(project.priority.rawValue)
                Spacer()
                Label("", systemImage: "checklist")

                Label("\(project.tasksOpened())", systemImage: "circle")
                    .labelStyle(.trailingIcon)
                Label("\(project.tasksClosed())", systemImage: "checkmark.circle")
                    .labelStyle(.trailingIcon)
            }
            //.font(.caption)
        }
        .foregroundColor(project.theme.accentColor)
    }
}

#Preview {
    let projectCardPreview = ProjectCardView(project: Project.sampleProjects[1])
        .background(.green)
    return projectCardPreview
}
