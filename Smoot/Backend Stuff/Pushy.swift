//
//  Pushy.swift
//  Smoot
//
//  Created by Paul Wiesinger on 30.05.18.
//  Copyright © 2018 73. All rights reserved.
//

import UserNotifications

class Pushy {
    
    let title = "Zeit sich fertig zu machen!"
    
    
    var eventTitle: String?
    var actualStartTime: Date
    var actualArrivalTime: Date
    var vorlaufZeit: Int // the time in minutes, before the event, where we should send the notification
    
    init(eventTitle: String, startTime: Date, arrivalTime: Date, vorlaufZeit: Int) {
        self.eventTitle = eventTitle
        self.actualStartTime = startTime
        self.actualArrivalTime = arrivalTime
        self.vorlaufZeit = vorlaufZeit
    }
    
    
    func deployMessage(repeats: Bool = false) -> String {
        let notificationID = UUID.init().uuidString
        
        let content = UNMutableNotificationContent.init()
        content.title = title
        content.body = messageBodyBuilder()
        
        
        let date = Date.init(timeIntervalSince1970: (Date.init().timeIntervalSince1970 - Double(vorlaufZeit*60)))
        
        let components = Calendar.current.dateComponents([.weekday, .hour,.minute], from: date)

        
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: components, repeats: repeats)
        
        let request = UNNotificationRequest.init(identifier: notificationID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        return notificationID
    }
    
    
    private func messageBodyBuilder() -> String {
        return "\(eventTitle ?? "Dein Termin") beginnt um \(dateFormatted), du solltest also langsam damit beginnen dich vorzubereiten."
    }
    
    
    private func dateFormatted() -> String {
        return ""
    }
 }
