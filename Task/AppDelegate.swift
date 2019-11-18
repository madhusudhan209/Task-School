//
//  AppDelegate.swift
//  Task
//
//  Created by Madhusudhan on 12/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//

import UIKit
import CoreData
import Reachability

/**
 The purpose of the `AppDelegate` is handling all the `UIApplication` methods and its delagate methods to handle `UIApplication` configurations
 
 This class will be fired from `UIApplicationMain` interface implementaion
 
 The `AppDelegate` class is a subclass of the `UIResponder`,
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// root object for the current application
    var window: UIWindow?
    
    /// The reachability for the internet Reachability.
    let internetReachability = Reachability()!
    
    /// The Bool for the internet availablity.
    var internetAvailability : Bool = false
    
    /// This method is the initial method which is called after opening the application. In this method all the initialization of object required globally for reusing in entire app will be done
    /// - Parameters:
    ///   - application: application object
    ///   - launchOptions: launchOptions objects
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /**
         Reachability to find out whether internet is availble or not in a device for calling web api's
         */
        if internetReachability.connection != .none {
            internetAvailability = true
            print("Internet connection OK")
        }
        
        /**
         For find out Internet when goes On or Off automatically
         */
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(note:)),name: Notification.Name.reachabilityChanged,object: internetReachability)
        do{
            try internetReachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
        return true
    }
    
    /// Application local database is closed when application is terminated
    /// - Parameter application: application object
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Network Finder
    
    /**
     It triggers the breaking of the fullname being in the `txtFullName` textfield into its components.
     
     If the `reachability` *does contain any wifi* then netAvailability true. In the other case, the `reachability` *does contain any cellular*  then netAvailability true. In the other case, the `reachability` *does contain none means no interner*  then netAvailability false.

     
     If the `reachability` *does contain any text* then nothing happens. In the opposite case, the fullname is broken into its parts (first name and last name) and each value is set to the `txtFirstName` and `txtLastName` respectively.
     
     - Parameter sender: The NSNotifcation inovkes this Reachability
     
     - SeeAlso: `reachabilityChanged(_:)`
     */
    @objc func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            internetAvailability = true
            print(ServiceManager.shared.checkInternetAvailability())
        case .cellular:
            print("Reachable via Cellular")
            internetAvailability = true
            print(ServiceManager.shared.checkInternetAvailability())
        case .none:
            print("Network not reachable")
            internetAvailability = false
            print(ServiceManager.shared.checkInternetAvailability())
        }
        
    }

    // MARK: - Core Data stack
    
    /// Object that handles with core data synchronisations
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Task")
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
    
    /// Method to save the coredata objects in to local
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

