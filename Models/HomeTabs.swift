//
//  HomeTabs.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 16/06/2024.
//

import Foundation

enum Tabs: String, Identifiable, Hashable, Equatable {
    case home = "Home"
    case tasks4today = "Today"
    case quickNote = "Quick note"
    
    var id: String {
        self.rawValue
    }
}
