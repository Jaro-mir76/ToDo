//
//  WagonikiStacja.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 07/02/2024.
//

import SwiftUI
/*
@MainActor
class WagonikiStacja: ObservableObject {
    @Published var projects: [Project] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("wagoniki.data")
    }
    
    func load() async throws {
        let task = Task<[Project], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let project = try JSONDecoder().decode([Project].self, from: data)
            return project
        }
        let projects = try await task.value
        self.projects = projects
    }
    
    func save(projects: [Project]) async throws {
            let task = Task {
                let data = try JSONEncoder().encode(projects)
                let outfile = try Self.fileURL()
                try data.write(to: outfile)
            }
            _ = try await task.value
        }
}
*/
