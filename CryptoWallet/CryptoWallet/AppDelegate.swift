//
//  AppDelegate.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CryptoWalletModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Ошибка инициализации хранилища Core Data: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let user = fetchUser()
        
        if user.isAuthorized {
            showCoinsListTableViewController()
        } else {
            showAuthViewController()
        }
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    func fetchUser() -> User {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1
        
        do {
            let users = try context.fetch(request)
            if let user = users.first {
                return user
            } else {
                let newUser = User(context: context)
                newUser.isAuthorized = false
                try context.save()
                return newUser
            }
        } catch {
            fatalError("Ошибка при получении пользователя из Core Data: \(error)")
        }
    }
    
    func showCoinsListTableViewController() {
        let viewModel = CoinsListViewModel()
        let coinsListTableViewController = CoinsListTableViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: coinsListTableViewController)
        window?.rootViewController = navigationController
    }
    
    func showAuthViewController() {
        let authViewModel = AuthViewModel()
        let authViewController = AuthViewController(authViewModel: authViewModel)
        window?.rootViewController = authViewController
    }
}
