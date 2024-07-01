//
//  HomeTabs.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 16/06/2024.
//

import Foundation

enum Tabs: String, Identifiable, Hashable, Equatable {
    case home = "Projects"
    case tasks4today = "For today"
    case quickNote = "Quick note"
    
    var id: String {
        self.rawValue
    }
}
