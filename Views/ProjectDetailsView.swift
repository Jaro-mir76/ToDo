//
//  ProjectDetailsView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 01/11/2023.
//

import SwiftUI
import SwiftData

struct ProjectDetailsView: View {
    @Bindable var project: Project
    @State private var editingProject = Project.emptyProject
    @State private var isPresentingEdit = false
    @State var isPresentingNewTask = false
    @State var parentTask: ProjectsTask?
    
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Project info")){
                    VStack(alignment: .leading ){
                        HStack(alignment: .firstTextBaseline){
                            Label("", systemImage: "list.clipboard")
                            Text(project.projDescription)
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
                            Text("\(project.tasksCompleted)")
                            Text("/")
                            Text("\(project.tasksCount)")
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
                    if !project.tasks.isEmpty {
                        TasksListView(activeProject: project, parentTask: nil)
                    } else {
                        Text("There is not tasks, but you can create some ;)")
                    }
                }
            }
            .navigationTitle(project.projName)
            .toolbar{
                Button("Edit"){
                    editingProject.projName = project.projName
                    editingProject.projDescription = project.projDescription
                    editingProject.priority = project.priority
                    editingProject.dueDate = project.dueDate
                    editingProject.isCompleted = project.isCompleted
                    editingProject.tasks = project.tasks
                    editingProject.theme = project.theme
                    isPresentingEdit = true
                }
            }
            .sheet(isPresented: $isPresentingEdit){
                NavigationStack{
                    ProjectEditView(project: $editingProject)
                    .navigationTitle(project.projName)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel") {
                                isPresentingEdit = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Done") {
                                project.projName = editingProject.projName
                                project.projDescription = editingProject.projDescription
                                project.priority = editingProject.priority
                                project.dueDate = editingProject.dueDate
                                project.isCompleted = editingProject.isCompleted
                                project.tasks = editingProject.tasks
                                project.theme = editingProject.theme
                                isPresentingEdit = false
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresentingNewTask){
                NavigationStack{
                    @State var newtask = ProjectsTask.emptyTask
                    TasksEditView(task: $newtask)
                        .navigationTitle("New task")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction){
                                Button("Cancel", action: {
                                    isPresentingNewTask = false
                                    }
                                )
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Add", action: {
                                        newtask.project = project
                                        newtask.parentTask = parentTask
                                        project.tasks.append(newtask)
                                    project.updateStats()
                                        isPresentingNewTask = false
                                    }
                                )
                            }
                        }
                }
            }
        }
        .onAppear(perform: {project.updateStats()})
    }
}

#Preview {
    ProjectDetailsView(project: Project.sampleProjects[0])
}
