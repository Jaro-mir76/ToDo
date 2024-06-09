//
//  TaskDuration.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 02/06/2024.
//

import SwiftUI

enum TaskDurationMinutes: Int, CaseIterable, Identifiable, Codable{
    
    case tDurMin0 = 0
    case tDurMin5 = 5
    case tDurMin10 = 10
    case tDurMin15 = 15
    case tDurMin20 = 20
    case tDurMin25 = 25
    case tDurMin30 = 30
    case tDurMin35 = 35
    case tDurMin40 = 40
    case tDurMin45 = 45
    case tDurMin50 = 50
    case tDurMin55 = 55
    case tDurMin60 = 60
    var id: Int {
        rawValue
    }
}

enum TaskDurationHours: Int, CaseIterable, Identifiable, Codable{
    
    case tDurH0, tDurH1, tDurH2, tDurH3, tDurH4, tDurH5, tDurH6, tDurH7, tDurH8, tDurH9, tDurH10, tDurH11, tDurH12, tDurH13, tDurH14, tDurH15, tDurH16, tDurH17, tDurH18, tDurH19, tDurH20, tDurH21, tDurH22, tDurH23
    var id: Int {
        rawValue
    }
}
