//
//  ProjView_tmp_2.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 30/06/2024.
//

import SwiftUI

struct ProjView_tmp_2: View {
    
    @Bindable var proj: Project
    @EnvironmentObject var stateManager: StateManager
    
    @State private var editingProject = Project.emptyProject
    @State private var isPresentingEdit = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        VStack {
            let _ = print("ProjectDetailsView - nav path count \(stateManager.navigationPath.count)")
            let _ = print("proj name \(proj.projName)")
            Text (proj.projName)
            Text (proj.projDescription)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("Project name: \(proj.projName)")
            Text("Project desc: \(proj.projDescription)")
            Text("Project task cout: \(proj.tasks.count)")
            Text("Proj  priority: \(proj.priority.rawValue)")
        }
        Button {
                stateManager.navigationPath.removeLast()
        } label: {
            Text("Back")
        }

            List{
                Section(header: Text("Project info").foregroundColor(.black)){
                    VStack(alignment: .leading ){
                        HStack(alignment: .firstTextBaseline){
                            Label("", systemImage: "list.clipboard")
                            Text(proj.projDescription)
                        }
                        HStack(alignment: .lastTextBaseline){
                            Label("", systemImage: "figure.walk.motion")
                            Text(proj.priority.rawValue)
                            Spacer()
                            Label("", systemImage: "flag.checkered")
                            Text(proj.dueDate.formatted(date: .numeric , time: .omitted))
                        }
                        HStack(alignment: .lastTextBaseline){
                        }
                        HStack {
                            Spacer()
                            Label("", systemImage: "checklist")
                            Text("\(proj.tasksCompleted)")
                            Text("/")
                            Text("\(proj.tasksCount)")
                            Spacer()
                        }
                    }
                }
                .listRowBackground(proj.theme.mainColor)
            }
        

        
//        NavigationStack{
//            List{
//                Section(header: Text("Project info").foregroundColor(.black)){
//                    VStack(alignment: .leading ){
//                        HStack(alignment: .firstTextBaseline){
//                            Label("", systemImage: "list.clipboard")
//                            Text(proj.projDescription)
//                        }
//                        HStack(alignment: .lastTextBaseline){
//                            Label("", systemImage: "figure.walk.motion")
//                            Text(proj.priority.rawValue)
//                            Spacer()
//                            Label("", systemImage: "flag.checkered")
//                            Text(proj.dueDate.formatted(date: .numeric , time: .omitted))
//                        }
//                        HStack(alignment: .lastTextBaseline){
//                        }
//                        HStack {
//                            Spacer()
//                            Label("", systemImage: "checklist")
//                            Text("\(proj.tasksCompleted)")
//                            Text("/")
//                            Text("\(proj.tasksCount)")
//                            Spacer()
//                        }
//                    }
//                }
//                .listRowBackground(proj.theme.mainColor)
////                .foregroundColor(proj.theme.accentColor)
////                Section(header:
////                    HStack{
////                        Text("Tasks").foregroundColor(.black)
////                        Spacer()
////                        Button(action: {
////                            stateManager.isPresentingNewTask = true
////                        }, label: {
////                            Label("", systemImage: "plus.circle.fill")
////                        })
////                    }
////                ){
////                    if !proj.tasks.isEmpty {
////                        TasksListView(activeProject: proj, parentTask: nil)
////                    } else {
////                        Text("There are no tasks, so lets plan something crazy 🥸")
////                    }
////                }
////                .listRowBackground(proj.theme.mainColor)
////                .foregroundColor(proj.theme.accentColor)
//            }
//            .navigationTitle(proj.projName)
//            .toolbar{
//                Button("Edit"){
//                    proj.copyProject(to: editingProject)
//                    isPresentingEdit = true
//                }
//            }
//            .sheet(isPresented: $isPresentingEdit){
//                NavigationStack{
//                    ProjectEditView(project: $editingProject)
//                    .navigationTitle(proj.projName)
//                    .toolbar {
//                        ToolbarItem(placement: .cancellationAction){
//                            Button("Cancel") {
//                                isPresentingEdit = false
//                            }
//                        }
//                        ToolbarItem(placement: .confirmationAction){
//                            Button("Done") {
//                                editingProject.copyProject(to: proj)
//                                isPresentingEdit = false
//                            }
//                        }
//                    }
//                }
//            }
//            .sheet(isPresented: $stateManager.isPresentingNewTask){
//                NavigationStack{
//                    @State var newtask = ProjectTask.emptyTask
//                    TasksEditView(task: $newtask)
//                        .navigationTitle("New task")
//                        .toolbar {
//                            ToolbarItem(placement: .cancellationAction){
//                                Button("Cancel", action: {
//                                    stateManager.isPresentingNewTask = false
//                                    }
//                                )
//                            }
//                            ToolbarItem(placement: .confirmationAction){
//                                Button("Add", action: {
//                                        newtask.project = proj
//                                    newtask.parentTask = stateManager.parentTask
//                                    proj.tasks.append(newtask)
//                                    proj.updateStats()
//                                    stateManager.isPresentingNewTask = false
//                                    }
//                                )
//                            }
//                        }
//                }
//            }
//        }
    }
}

#Preview {
    ProjView_tmp_2(proj: Project.emptyProject)
}
