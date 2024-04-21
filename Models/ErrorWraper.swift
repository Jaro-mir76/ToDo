//
//  ErrorWraper.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 11/02/2024.
//

import Foundation

struct ErrorWraper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
