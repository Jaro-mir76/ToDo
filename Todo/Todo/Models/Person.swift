//
//  Person.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import Foundation

struct Person: Identifiable {
    let id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
