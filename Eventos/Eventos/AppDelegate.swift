//
//  AppDelegate.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: EventsCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationController = UINavigationController()
        coordinator = EventsCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        setupNavigationBarAppearance(for: application)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

extension AppDelegate {
    func setupNavigationBarAppearance(for application: UIApplication) {
        let navigationBarAppearance = UINavigationBarAppearance()
        let background = Flavor.shared.colors.background
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: background.onColor,
            .font: Flavor.shared.fonts.quickSandBold.withSize(28)
        ]

        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = background.color
        navigationBarAppearance.titleTextAttributes = attributes
        navigationBarAppearance.largeTitleTextAttributes = attributes
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = background.onColor
    }
}
