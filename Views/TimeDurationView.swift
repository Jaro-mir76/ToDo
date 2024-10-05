//
//  TimeDurationView.swift
//  Todo
//
//  Created by Jaromir Jagieluk on 12/05/2024.
//

import SwiftUI

struct TimeDurationView: View {
    var duration: Int
    
    var body: some View {
        let timeDuration = Duration.seconds(duration)
        switch duration {
        case 0..<3600:
            let formatedDuration = timeDuration.formatted(.time(pattern: .minuteSecond(padMinuteToLength: 2)))
            Text("\(formatedDuration)")
        default:
            let formatedDuration = timeDuration.formatted(.time(pattern: .hourMinuteSecond(padHourToLength: 2)))
            Text("\(formatedDuration)")
        }
    }
}

#Preview {
    TimeDurationView(duration: 99)
}
