//
//  AppDelegate.swift
//  OurMemory
//
//  Created by 이승기 on 2021/01/19.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseMessaging


@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        KaKaoLoginWrapper.shared.initWithKakaoSDK()
        
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions:UNAuthorizationOptions = [.alert,.sound,.badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in})
        application.registerForRemoteNotifications()
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)
                let root = storyboard.instantiateViewController(withIdentifier: "IntroViewController")
        let nvc = UINavigationController(rootViewController: root)
        self.window?.rootViewController = nvc
        // Override point for customization after application launch.
        return true
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return KaKaoLoginWrapper.shared.isKakaoAcountLoginCallBack(url:url)
//    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        
        print(String(format:"[Log] deviceToken : %@", deviceTokenString))
        
    }
    
    // MARK: Notification
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge,.sound,.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let token = fcmToken {
        let dataDic:[String:String] = ["token":token]
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil,userInfo: dataDic)
        }
        
        Messaging.messaging().token(completion: { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
              } else if let token = token {
                print("FCM registration token: \(token)")
                let test:[String:Any] = [
                             "snsId": "testId_004",
                             "snsType": 3,
                             "pushToken": token,
                             "name": "김동영",
                             "birthday": "0724",
                             "isSolar": true,
                             "isBirthdayOpen": "true"
                ]
                if let url = URL(string: "http://13.125.146.53:8080/OurMemory/v1/signUp/") {
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    
                    let jsondata = try? JSONSerialization.data(withJSONObject: test, options: [.prettyPrinted])
                    request.httpBody = jsondata
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data, error == nil else {
                            print(error?.localizedDescription ?? "No data")
                            return
                        }
                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                        if let responseJSON = responseJSON as? [String: Any] {
                            print(responseJSON)
                        }
                    }

                    task.resume()
                    
                }
              }
        })
        
       
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "OurMemory")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

