//
//  TasksDetailsView.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 01/11/2023.
//

import SwiftUI

struct TasksDetailsView: View {
    @Binding var task: ProjectsTask
    @State private var editingTask = ProjectsTask.emptyTask
    @State private var isPresentingEdit = false
    @State var isPresentingNewTask = false
    @State private var newNote = ""
    
    var body: some View {
        
        NavigationStack{
            HStack{
                if !task.subTask.isEmpty {
                    Text("\(task.tasksClosed())/\(task.tasksOpened()+task.tasksClosed())")
                } else {
                    TaskStatusButton(isCompleted: $task.isCompleted)
                }
                Text(task.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            List{
                Section(header: Text("Tasks details")){
                    VStack(alignment: .leading){
                        Text(task.description)
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
                    ForEach(task.notes){notes in
                        NotesCardView(notes: notes)
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
                            .accessibilityLabel("Add attendee")
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
                    if task.subTask.isEmpty {
                        Text("There is not subtasks, but you can add one ;)")
                    } else {
                        TasksListView(tasks: $task.subTask, isSubGroup: false)
                     
                    }
                }
            }
            //.navigationTitle(task.name)
            .lineLimit(3)
            .toolbar{
                Button("Edit"){
                    isPresentingEdit = true
                    editingTask = task
                }
            }
            .sheet(isPresented: $isPresentingEdit){
                NavigationStack{
                    TasksEditView(task: $editingTask)
                        .navigationTitle(task.name)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction){
                            Button("Cancel") {
                                    isPresentingEdit = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Done") {
                                    isPresentingEdit = false
                                    task = editingTask
                                }
                            }
                        }
                }
            }
            .sheet(isPresented: $isPresentingNewTask){
                NavigationStack{
                    NewTaskView(tasks: $task.subTask, isPresentingNewTask: $isPresentingNewTask)
                        .navigationTitle("New task")
                }
            }
        }
    }
}

#Preview {
    return TasksDetailsView(task: .constant(Project.sampleProjects[1].tasks[2]))
}
