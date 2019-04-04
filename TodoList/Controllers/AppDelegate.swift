//
//  AppDelegate.swift
//  TodoList
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    var dateComponents = DateComponents()
    let date = Date() // save date, so all components use the same date
    let calendar = Calendar.current // or e.g. Calendar(identifier: .persian)
    let notificationCenter = UNUserNotificationCenter.current()
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"
        
        dateComponents.calendar = Calendar.current
        dateComponents.day = calendar.component(.weekday, from: date)-1
        dateComponents.hour = calendar.component(.hour, from: date)
        dateComponents.minute = calendar.component(.minute, from: date)
        dateComponents.second = calendar.component(.second, from: date)+10

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            print(granted)
            print(error ?? "noErr")
            print(self.dateComponents)
            
            self.notificationCenter.add(request) { (error) in
                if error != nil {
                    print(error!)
                }
            }
            
        }
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        center.delegate = self
        completionHandler([.alert, .badge,.sound])
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    
}

