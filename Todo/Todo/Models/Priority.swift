//
//  Priority.swift
//  Wagoniki
//
//  Created by Jaromir Jagieluk on 29/10/2023.
//

import Foundation

enum Priority: String, CaseIterable, Identifiable {
    
    case critical = "Critical"
    case high = "High"
    case medium = "Medium"
    case low = "Low"
    case dontCare = "Don't care"
    
    /*var name: String{
        rawValue
    }*/
    
    var id: String {
        rawValue
    }
}
