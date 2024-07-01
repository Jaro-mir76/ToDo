//
//  ProjView_tmp.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 29/06/2024.
//

import SwiftUI
import SwiftData

struct ProjView_tmp: View {

    let projId: UUID
    @Query private var projects: [Project]
    private var project: Project
    @EnvironmentObject var stateManager: StateManager
    
    init(projId: UUID) {
//        var localProjectId = projId
        let _ = print("init projId \(projId)")
        self._projects = Query(filter: #Predicate<Project>{$0.id == projId})
        
//        let localProjects = Query(filter: #Predicate<Project>{$0.id == projId})
        let _ = print("self._projects count \(self._projects.wrappedValue.count)")
//        self._projects = Query(filter: #Predicate{$0.id == localProjectId})
//        if let prjTmp = localProjects.wrappedValue.first(where: {$0.id == projId}){
        let prjTmp = self._projects.wrappedValue.first(where: {$0.id == projId})
        let _ = print("prjTmp.projName \(prjTmp?.projName)")
//            self.project = prjTmp!
//        } else {
//            self.project = Project.emptyProject
//        }
            
        self.projId = projId
        self.project = prjTmp ?? Project.emptyProject
//        self.stateManager = EnvironmentObject<StateManager>.init()
//        self.stateManager = StateManager()
    }
    
    var body: some View {
        
        var prj = projects.first
        VStack(alignment: .leading){
//            List(projects){ project in
                Text("Project name")
                    .font(.footnote)
    //            let fetchDescriptor = FetchDescriptor<Project>(predicate: #Predicate{$0.id == projId})
    //            if let project = projects.first(where: {$0.id == projId}){
                    let _ = print("project name \(prj?.projName)")
                    
            Text(prj!.projName)
            Text(project.projName)
//            }
            
//            let fetchDescriptor = FetchDescriptor<Project>(predicate: #Predicate{$0.id == projId})
//            if let project = projects.first(where: {$0.id == projId}){
                
//                Text(project.projName)
//            }
            

        }
        Button {
                stateManager.navigationPath.removeLast()
        } label: {
            Text("Back")
        }
//        let _ = print ("path count \(stateManager.navigationPath.count)")
    }
}

#Preview {
    ProjView_tmp(projId: UUID())
}
