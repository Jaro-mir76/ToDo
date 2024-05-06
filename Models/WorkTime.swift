//
//  WorkTime.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 04/05/2024.
//

import Foundation


@MainActor
final class WorkTime: ObservableObject {
    @Published var workingTime = 0
    @Published var running: Bool = false
    private weak var timer: Timer?
    private var frequency: TimeInterval { 1.0 / 60.0 }
    
    func startTimer(from: Int = 0) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [weak self] timer in
            self?.updateTime()
        }
        workingTime = from
        running = true
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    nonisolated func updateTime() {
        Task {@MainActor in
            if running {
                workingTime += 1
            } else {
//                timer?.invalidate()
            }
        }
    }
}
