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
                Section(header: Text("Project info").foregroundColor(.black)){
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
                .listRowBackground(project.theme.mainColor)
//                .foregroundColor(project.theme.accentColor)
                Section(header:
                    HStack{
                        Text("Tasks").foregroundColor(.black)
                        Spacer()
                    Button(action: {
                        isPresentingNewTask = true
                    }, label: {
//                        Text("Add task").foregroundColor(.black)
                        Label("", systemImage: "plus.circle.fill")
                    })
//                    Button("Add task"){
//                            isPresentingNewTask = true
//                        }
                    }
                ){
                    if !project.tasks.isEmpty {
                        TasksListView(activeProject: project, parentTask: nil)
                    } else {
                        Text("There are no tasks, so lets plan something crazy ;D")
                    }
                }
                .listRowBackground(project.theme.mainColor)
//                .foregroundColor(project.theme.accentColor)
            }
            .navigationTitle(project.projName)
            .toolbar{
                Button("Edit"){
                    project.copyProject(to: editingProject)
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
                                editingProject.copyProject(to: project)
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
