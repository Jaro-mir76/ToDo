//
//  TasksDetailsView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 01/11/2023.
//

import SwiftUI

struct TasksDetailsView: View {
    var activeProject: Project
    var parentTask: ProjectsTask?
    @Bindable var task: ProjectsTask
    @State private var editingTask = ProjectsTask.emptyTask
    @State private var isPresentingEdit = false
    @State var isPresentingNewTask = false
    @State private var newNote = ""
    
    var body: some View {
        NavigationStack{
            HStack{
                if !task.subTask.isEmpty {
                    Text("\(task.tasksCompleted)/\(task.tasksCount)")
                } else {
                    TaskStatusButton(isCompleted: $task.taskIsCompleted)
                }
                Text(task.taskName)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
            .lineLimit(1)
            List{
                Section(header: Text("Tasks details")){
                    VStack(alignment: .leading){
                        Text(task.taskDescryption)
                        HStack{
                            Label("", systemImage: "figure.walk.motion")
                            Text(task.priority.rawValue)
                            Spacer()
                            Label("", systemImage: "calendar")
                            Text(task.dueDate.formatted(date: .numeric, time: .omitted))
                                .font(.callout)
                        }
                        HStack{
                            Label("", systemImage: "flag.checkered")
                            Text(task.estimatedImplTimeMinutes.description)
                               // .font(.callout)
                            Spacer()
                            Label("", systemImage: "stopwatch")
                            Text(task.realImplTimeMinutes.description)
                        }
                    }
                }
                Section(header: Text("Notes")){
                    if !task.notes.isEmpty {
                        ForEach(task.notes){note in
                            NotesCardView(notes: note)
                        }
                    }
                }
                HStack {
                    TextField("New note", text: $newNote)
                    Button(action: {
                        withAnimation {
                            let note = TasksNote(note: newNote, author: Person(name: "Adam"))
                            task.notes.append(note)
                            newNote = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add note")
                    }
                    .disabled(newNote.isEmpty)
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
                    if !task.subTask.isEmpty {
                        TasksListView(activeProject: activeProject, parentTask: task)
                    } else {
                        Text("There is not subtasks, but you can add one ;)")
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .toolbar{
                Button("Edit"){
                    editingTask.taskIsCompleted = task.taskIsCompleted
                    editingTask.taskName = task.taskName
                    editingTask.taskDescryption = task.taskDescryption
                    editingTask.priority = task.priority
                    editingTask.estimatedImplTimeMinutes = task.estimatedImplTimeMinutes
                    editingTask.realImplTimeMinutes = task.realImplTimeMinutes
                    editingTask.dueDate = task.dueDate
                    isPresentingEdit = true
                }
            }
            .sheet(isPresented: $isPresentingEdit){
                NavigationStack{
                    TasksEditView(task: $editingTask)
                        .navigationTitle(task.taskName)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction){
                            Button("Cancel") {
                                    isPresentingEdit = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Done") {
                                    task.taskIsCompleted = editingTask.taskIsCompleted
                                    task.taskName = editingTask.taskName
                                    task.taskDescryption = editingTask.taskDescryption
                                    task.priority = editingTask.priority
                                    task.estimatedImplTimeMinutes = editingTask.estimatedImplTimeMinutes
                                    task.realImplTimeMinutes = editingTask.realImplTimeMinutes
                                    task.dueDate = editingTask.dueDate
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
                                Button("Cancel") {
                                    isPresentingNewTask = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Add") {
                                    newtask.project = activeProject
                                    newtask.parentTask = parentTask
                                    
                                    let _ = print("TasksDetailsView Add Button - active Project variable: \(String(describing: activeProject.projName))")
                                    let _ = print("TasksDetailsView add Button - Parent task name context: \(String(describing: parentTask?.taskName))")
                                    let _ = print("TasksDetailsView add Button - newtask.project: \(String(describing: newtask.project?.projName))")
                                    let _ = print("TasksDetailsView add Button - newtask.parentTask?.taskName: \(String(describing: newtask.parentTask?.taskName))")
                                    let _ = print("TasksDetailsView add Button - newtask.taskName: \(String(describing: newtask.taskName))")
                                    
                                    task.subTask.append(newtask)
                                    activeProject.updateStats()
                                    isPresentingNewTask = false
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    return TasksDetailsView(activeProject: Project.sampleProjects[0], parentTask: ProjectsTask.emptyTask ,task: (Project.sampleProjects[1].tasks[2]))
}
