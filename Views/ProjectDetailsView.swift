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
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
            List{
                Section(header: Text("Project info").foregroundColor(.black)){
                    VStack(alignment: .leading ){
                        HStack(alignment: .center){
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
                            stateManager.isPresentingNewTask = true
                        }, label: {
                            Label("", systemImage: "plus.circle.fill")
                        })
                    }
                ){
                    if !project.tasks.isEmpty {
                        TasksListView(activeProject: project, parentTask: nil)
                    } else {
                        Text("There are no tasks, so lets plan something crazy 🥸")
                    }
                }
                .listRowBackground(project.theme.mainColor)
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
            .sheet(isPresented: $stateManager.isPresentingNewTask){
                NavigationStack{
                    @State var newtask = ProjectTask.emptyTask
                    TasksEditView(task: $newtask)
                        .navigationTitle("New task")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction){
                                Button("Cancel", action: {
                                    stateManager.isPresentingNewTask = false
                                    }
                                )
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Add", action: {
                                        newtask.project = project
                                    newtask.parentTask = stateManager.parentTask
                                        project.tasks.append(newtask)
                                        project.updateStats()
                                    stateManager.isPresentingNewTask = false
                                    }
                                )
                            }
                        }
                }
            }
            .onAppear(){
                project.updateStats()
                stateManager.activeProject = project
                stateManager.parentTask = nil
            }
    }
}

#Preview(traits: .modelContainerSampleData) {
    @Previewable @Query var projects: [Project]
    ProjectDetailsView(project: projects[0])
        .environmentObject(StateManager())
}
