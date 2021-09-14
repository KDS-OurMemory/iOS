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
        
        KaKaoLoginWrapper.shared.initWithKakaoSDK()
        
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
        Router.defaultRouter.setupAppNavigation(appNavigation: MyAppNavigation())
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return KaKaoLoginWrapper.shared.isKakaoAcountLoginCallBack(url:url)
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        
        print(String(format:"[Log] deviceToken : %@", deviceTokenString))
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(String(format: "[Log] Failed to get Push Noti %@", error.localizedDescription))
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
            let saveDataModel:AppSaveDataModel = AppSaveDataModel()
            saveDataModel.saveFCMTokenData(fcmToken:token)
        let dataDic:[String:String] = ["token":token]
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil,userInfo: dataDic)
            
        }
        
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

// MARK: UIViewController Router

extension UIViewController {
    @objc func onReadyPushVC() {
        
    }
}

struct MyAppNavigation: AppNavigation {
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        to.onReadyPushVC()
        from.navigationController?.pushViewController(to, animated: true)
    }
    
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        
        if let navigation = navigation as? NEXTVIEW {
            switch navigation {
            case .NEXTVIEW_LOGIN:
                return LoginViewController().initiailizeSubViewClass()
            case .NEXTVIEW_MAIN:
                return MainViewController().initiailizeSubViewClass()
            case .NEXTVIEW_FRIENDSLIST:
                return FriendViewController()
            case .NEXTVIEW_ROOMLIST:
                return RoomTableViewController()
            case .NEXTVIEW_ROOMDETAIL:
                return RoomDetailViewController()
            case .NEXTVIEW_SCHEDULE:
                return ScheduleViewController()
            }
            
        }
        return UIViewController()
    }
}

