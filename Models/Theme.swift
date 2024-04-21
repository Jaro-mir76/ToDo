//
//  Theme.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 10/11/2023.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    
    case blue = "blue"
    case brown = "brown"
    case cyan = "cyan"
    case yellow = "yellow"
    case clear = "clear"
    case gray = "gray"
    case green = "green"
    case indigo = "indigo"
    case mint = "mint"
    case orange = "orange"
    case pink = "pink"
    case purple = "purple"
    case red = "red"
    case teal = "teal"
    case white = "white"
    
    var accentColor: Color {
        switch self {
        case .yellow, .brown, .clear, .gray, .mint, .orange, .pink, .purple, .white: return .black
        case .blue, .cyan, .green, .indigo, .red, .teal: return .white
        }
    }
    var mainColor: Color {
        switch self {
        case .blue: return .blue
        case .brown: return .brown
        case .cyan: return .cyan
        case .yellow: return .yellow
        case .clear: return .clear
        case .gray: return .gray
        case .green: return .green
        case .indigo: return .indigo
        case .mint: return .mint
        case .orange: return .orange
        case .pink: return .pink
        case .purple: return .purple
        case .red: return .red
        case .teal: return .teal
        case .white: return .white
        }
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}
