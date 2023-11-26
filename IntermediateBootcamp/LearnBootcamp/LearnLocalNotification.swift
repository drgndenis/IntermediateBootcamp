//
//  LearnLocalNotification.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 12.11.2023.
//

import SwiftUI
import UserNotifications

private class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuth() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            } else {
                print(success)
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is the first notification in my app"
        content.body = "This is soooo amazing"
        content.sound = .default
        content.badge = 1
        
        //time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //calendar
        
        var component = DateComponents()
        component.hour = 16
        component.minute = 59
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
        //location
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

struct LearnLocalNotification: View {
    var body: some View {
        VStack(spacing: 16) {
            Button("Request permission") {
               NotificationManager.instance.requestAuth()
            }
            Button("Schedule Notification") {
               NotificationManager.instance.scheduleNotification()
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    LearnLocalNotification()
}
