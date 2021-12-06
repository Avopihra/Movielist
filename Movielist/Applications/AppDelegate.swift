//
//  AppDelegate.swift
//  Movielist
//
//  Created by Viktoriya on 01.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let filmsViewController = FilmsViewController()
    let filmsCardViewController = FilmCardViewContoller()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let emptyCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        URLCache.shared = emptyCache
        
        let filmsNavigationController = UINavigationController(rootViewController: filmsViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = filmsNavigationController
        window?.makeKeyAndVisible()
        return true
    }
}
