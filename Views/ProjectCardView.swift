//
//  ProjectCardView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import SwiftUI

struct ProjectCardView: View {
    var project: Project
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(project.projName)
                .font(.headline)
            Spacer()
            HStack{
                Label("", systemImage: "figure.walk.motion")
                Text(project.priority.rawValue)
                Spacer()
                Label("", systemImage: "checklist")
                Text("\(project.tasksCompleted)")
                Text("/")
                Text("\(project.tasksCount)")
            }
        }
        .foregroundColor(project.theme.accentColor)
        .onAppear(perform: {project.updateStats()})
    }
        
}

#Preview(traits: .modelContainerSampleData) {
    ProjectCardView(project: Project.sampleProjects[0])
        .background(.green)
}
