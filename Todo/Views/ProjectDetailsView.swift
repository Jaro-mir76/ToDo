//
//  ProjectDetailsView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 01/11/2023.
//

import SwiftUI

struct ProjectDetailsView: View {
    @Binding var project: Project
    @State private var editingProject = Project.emptyProject
    @State private var isPresentingEdit = false
    @State var isPresentingNewTask = false
    
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Project info")){
                    VStack(alignment: .leading ){
                        HStack(alignment: .firstTextBaseline){
                            Label("", systemImage: "list.clipboard")
                            Text(project.description)
                        }
                        HStack(alignment: .lastTextBaseline){
                            Label("", systemImage: "figure.walk.motion")
                            Text(project.priority.rawValue)
                            Spacer()
                            Label("", systemImage: "flag.checkered")
                            Text(project.dueDate.formatted(date: .numeric , time: .omitted))
                        }
                        HStack(alignment: .lastTextBaseline){
                        }
                        HStack {
                            Spacer()
                            Label("", systemImage: "checklist")
                            Text("\(project.tasksClosed())")
                            Text("/")
                            Text("\(project.tasksOpened()+project.tasksClosed())")
                            Spacer()
                        }
                    }
                }
                Section(header:
                            HStack{
                                Text("Tasks")
                                Spacer()
                                Button("Add task"){
                                    isPresentingNewTask = true
                                }
                            }
                ){
                    if project.tasks.isEmpty {
                        Text("There is not tasks, but you can create some ;)")
                    } else {
                        TasksListView(tasks: $project.tasks, isSubGroup: false)
                     
                    }
                }
            }
            .navigationTitle(project.name)
            .toolbar{
                Button("Edit"){
                    isPresentingEdit = true
                    editingProject = project
                }
            }
            .sheet(isPresented: $isPresentingEdit){
                NavigationStack{
                    ProjectEditView(project: $editingProject)
                        .navigationTitle(project.name)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction){
                            Button("Cancel") {
                                    isPresentingEdit = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Done") {
                                    isPresentingEdit = false
                                    project = editingProject
                                }
                            }
                        }
                }
            }
            .sheet(isPresented: $isPresentingNewTask){
                NavigationStack{
                    NewTaskView(tasks: $project.tasks, isPresentingNewTask: $isPresentingNewTask)
                        .navigationTitle("New task")
                }
            }
        }
    }
}

#Preview {
    return ProjectDetailsView(project: .constant(Project.sampleProjects[1]))
}
