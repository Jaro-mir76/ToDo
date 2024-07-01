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
    
//    let projectId: UUID
//    @Query private var projects: [Project]
//    @Bindable
    
//    private var project: Project
    
    @State private var editingProject = Project.emptyProject
    @State private var isPresentingEdit = false
//    @State var isPresentingNewTask = false
//    @State var parentTask: ProjectTask?
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var stateManager: StateManager
    
//    init(projectId: UUID) {
//        self.projectId = projectId
//        
////        let fetchDescriptor = FetchDescriptor<Project>(predicate: #Predicate{$0.id == projectId})
//        
////        if let proj = projects.first(where: {$0.id == projectId}){
//            
////        if let project = projects.first(FetchDescriptor){
////            self.project = proj
////        }
//        
////        let fetchDescriptor = FetchDescriptor<Project>(predicate: #Predicate{$0.id == projectId})
//        
//        if let project = projects.first(where: {$0.id == projectId}){
//            self.project = project
//        } else {
//            self.project = Project.emptyProject
//        }
//        
//    }
    
    var body: some View {
        
//        var project = projects.first(where: {$0.id == projectId})!
//        project = prj
        
//        let _ = print("ProjectDetailsView - nav path count \(stateManager.navigationPath.count)")
//        let _ = print("proj name \(project.projName)")
//        Text (project.projName)
//        Text (project.projDescription)
        
//        NavigationStack{
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
//        }
            .onAppear(perform: {
                project.updateStats()
                stateManager.activeProject = project
                stateManager.parentTask = nil
            })
    }
}

#Preview {
    ProjectDetailsView(project: Project.emptyProject)
}
