//
//  LearnTimer.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 18.11.2023.
//

import SwiftUI

struct LearnTimer: View {
    let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    
    //Current Time
    /*
     @State var currentDate = Date()
     var dateFormatter: DateFormatter {
         let formatter = DateFormatter()
         formatter.timeStyle = .medium
         return formatter
     }
     */
    
    // Countdown
    /*
     @State private var count = 10
     @State private var finishedText: String? = nil
     */
    
    // Countdown to date
    /*
     @State private var timeRemaining = ""
     let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
     
     func updateTimeRemaining() {
         let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
         let hour = remaining.hour ?? 0
         let minute = remaining.minute ?? 0
         let second = remaining.second ?? 0
         
         timeRemaining = "\(hour):\(minute):\(second)"
     }
     */
    
    // Animation counter
    @State private var count = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [.purple, .black.opacity(0.97)]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            HStack(spacing: 15) {
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                    .shadow(color: .black, radius: 10, y: count == 1 ? 17 : 10)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                    .shadow(color: .black, radius: 10, y: count == 2 ? 17 : 10)
                Circle()
                    .offset(y: count == 3 ? -20 : 0)
                    .shadow(color: .black, radius: 10, y: count == 3 ? 17 : 10)
            }
            .frame(width: 200)
            .foregroundStyle(.white)
        }
        .ignoresSafeArea()
        .onReceive(timer, perform: { _ in
            withAnimation(.easeInOut(duration: 0.65)) {
                count = count == 4 ? 1 : count + 1
            }
        })
    }
}

#Preview {
    LearnTimer()
}
