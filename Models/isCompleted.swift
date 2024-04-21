//
//  isCompleted.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 07/02/2024.
//

import Foundation

public enum isCompleted: String, CaseIterable, Identifiable, Codable {
    
    case completed
    case notCompleted
    
    public init? (rawValue: Bool){
        self = rawValue ? .completed : .notCompleted
    }
    
    public var rawValue: Bool {
        switch self {
        case .completed:
            return true
        case .notCompleted:
            return false
        }
    }
    
    public var id: String {
        self.rawValue
    }
    
    public mutating func toggle() {
        self = self.rawValue == true ? .notCompleted : .completed
    }
}
