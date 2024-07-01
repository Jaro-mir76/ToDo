//
//  TasksDetailsView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 01/11/2023.
//

import SwiftUI

struct TasksDetailsView: View {
//    var activeProject: Project
//    var parentTask: ProjectTask?
    @Bindable var task: ProjectTask
    @State private var editingTask = ProjectTask.emptyTask
    @State private var isPresentingEdit = false
    @State var isPresentingNewTask = false
    @State private var newNote = ""
    @StateObject var workTime = WorkTime()
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
//        NavigationStack{
            HStack{
                if !task.subTask.isEmpty {
                    SubTasksStatus(task: task)
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
                Section(header: Text("Task details")){
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
                            Label("", systemImage: "stopwatch")
                            TimeDurationView(duration: workTime.workingTime)
                            Spacer()
                            Label("", systemImage: "flag.checkered")
                            Text(task.estimatedImplTimeString)
                        }
                    }
                }
                .listRowBackground(stateManager.activeProject?.theme.mainColor)
                Section(header: Text("Notes")){
                    if !task.notes.isEmpty {
                        ForEach(task.notes){note in
                            NotesCardView(notes: note)
                        }
                    }
                }
                .listRowBackground(stateManager.activeProject?.theme.mainColor)
                HStack {
                    TextField("New note", text: $newNote)
                    Button(action: {
                        withAnimation {
                            let note = TaskNote(note: newNote, author: Person(name: "Adam"))
                            task.notes.append(note)
                            newNote = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add note")
                    }
                    .disabled(newNote.isEmpty)
                }
                .listRowBackground(stateManager.activeProject?.theme.mainColor)
                Section(header:
                    HStack{
                        Text("Subtasks")
                        Spacer()
                        Button(action: {
                            isPresentingNewTask = true
                        }, label: {
                            Label("", systemImage: "plus.circle.fill")
                        })
                    }
                ){
                    if !task.subTask.isEmpty {
                        TasksListView(activeProject: stateManager.activeProject!, parentTask: stateManager.parentTask)
                    } else {
                        Text("There are no subtasks, so lets plan something 🤓")
                    }
                }
                .listRowBackground(stateManager.activeProject?.theme.mainColor)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .toolbar{
                Button("Edit"){
                    task.copyTask(to: editingTask)
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
                                    editingTask.copyTask(to: task)
                                    isPresentingEdit = false
                                }
                            }
                        }
                }
                .onAppear(){
                    workTime.running = false
                }
                .onDisappear(){
                    workTime.running = true
                }
            }
            .sheet(isPresented: $isPresentingNewTask){
                NavigationStack{
                    @State var newtask = ProjectTask.emptyTask
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
                                    newtask.project = stateManager.activeProject
                                    newtask.parentTask = stateManager.parentTask
                                    task.subTask.append(newtask)
                                    stateManager.activeProject?.updateStats()
                                    isPresentingNewTask = false
                                }
                            }
                        }
                }
                .onAppear(){
                    workTime.running = false
                }
                .onDisappear(){
                    workTime.running = task.subTask.isEmpty
                }
            }
        
        .onAppear(){
            if task.subTask.isEmpty {
                startTimer()
                workTime.running = task.taskIsCompleted ? false : true
            }
            workTime.workingTime = task.realImplTimeMinutes
        }
        .onDisappear(){
            stopTimer()
        }
        .onChange(of: task.taskIsCompleted){
            workTime.running = task.taskIsCompleted ? false : true  //stope timer if tasks is completed or start if was uncompleted
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                workTime.running = true
            } else {
                workTime.running = false
            }
        }
    }
    
    func startTimer(){
        workTime.startTimer(from: task.realImplTimeMinutes)
    }
    
    func stopTimer(){
        workTime.stopTimer()
        task.realImplTimeMinutes = workTime.workingTime
        stateManager.parentTask?.updateStats()
    }
}

#Preview {
    return TasksDetailsView(task: (Project.sampleProjects[0].tasks[0]))
}
