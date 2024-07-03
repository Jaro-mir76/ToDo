//
//  TasksListView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 10/12/2023.
//

import SwiftUI
import SwiftData

struct TasksListView: View {
    var activeProject: Project
    var parentTask: ProjectTask?
    //@Query
    private var tasks: [ProjectTask]
    @Environment(\.modelContext) private var modelContex
    @EnvironmentObject var stateManager: StateManager
    
    @Query private var forToday: [ForToday]
    
    init(activeProject: Project, parentTask: ProjectTask?) {
        //let projectId = activeProject.id      //left to check later @Query etc.
        self.activeProject = activeProject
        //let parentTaskId = parentTask?.id
        self.parentTask = parentTask
        /*let predicate = #Predicate<ProjectsTask> { projectTask in
            projectTask.project?.id == projectId && projectTask.parentTask?.id == parentTaskId
        }*/
        //self._tasks = Query(filter: predicate, sort: [SortDescriptor (\.id)])
        
        if let tasks = parentTask?.subTask {
            self.tasks = tasks.sorted(by: {$0.creationDate < $1.creationDate})
        } else {
            self.tasks = activeProject.tasks.filter({$0.parentTask == nil}).sorted(by: {$0.creationDate < $1.creationDate})
        }
    }
    
    var body: some View {
        ForEach(tasks, id: \.id){ task in

            switch task.subTask.isEmpty {
            case true:
                NavigationLink(value: task){
                    TaskCardView(task: task)
                        .swipeActions(edge: .leading, allowsFullSwipe: false){
                            Button {    // swipe action Complete <> Incomplete
                                task.taskIsCompleted.toggle()
                                activeProject.updateStats()
                            } label: {
                                Label(task.taskIsCompleted ? "Incomplete" : "Complete", systemImage: task.taskIsCompleted ? "checkmark.gobackward" : "checkmark.circle")
                            }
                            .tint(.green)
                            
                            Button { // swipe action -> to add to task 4 Today list
                                let taskId = task.id
                                let fetchDescriptor = FetchDescriptor<ForToday>(predicate: #Predicate{$0.task?.id == taskId}
                                )
                                do {
                                    let ile = try modelContex.fetchCount(fetchDescriptor)
                                    if ile == 0 {
                                        @State var newTask4Today = ForToday(today: Date(), task: task)
                                        modelContex.insert(newTask4Today)
                                    }
                                } catch {
                                    print("Upss, we have some problem with counting tasks on ForToday list")
                                }
                            } label: {
                                Label("For today", systemImage:  "note.text.badge.plus")
                            }
                            .tint(.yellow)
                        }
                        
                        .swipeActions(edge: .trailing, allowsFullSwipe: false){
                            Button(role: .destructive) {
                                if let context = task.modelContext {
                                    context.delete(task)
                                    activeProject.updateStats()
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                }
            case false:
                @Bindable var task = task
                HStack {
                    VStack (alignment: .leading){
                        NavigationLink(value: task){
                            TaskCardView(task: task)
                        }
                    }
                    
                }
                if task.subTaskUnfold {
                    TasksListView(activeProject: activeProject, parentTask: task)
                    .padding(.leading, 30)
                }
            }
        }
    }
}

#Preview {
    TasksListView(activeProject: Project.sampleProjects[0] ,parentTask: ProjectTask.emptyTask)
}
