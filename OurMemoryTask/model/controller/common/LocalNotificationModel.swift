//
//  LocalNotificationModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/18.
//

import UIKit

class LocalNotificationModel: NSObject {

    static let sharedLocalNotification = LocalNotificationModel()
    let userLocalNotiCenter:UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        
        
        userLocalNotiCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    func addLocalNotification(title:String,body:String,identifier:String,dateComponents:DateComponents,repeats:Bool) {
        let content = UNMutableNotificationContent()
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        
        content.title = title
        content.body = body
        content.sound = .default
        
        content.badge = 2
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        userLocalNotiCenter.add(request) { error in
            if let err = error {
                print(err)
            }
        }
        
    }
    
    func sendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "알림 테스트"
        notificationContent.body = "이것은 알림을 테스트 하는 것이다"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)

        userLocalNotiCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
