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
//    let filmCardViewContoller = FilmCardViewContoller()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let filmsNavigationController = UINavigationController(rootViewController: filmsViewController)
//        let filmCardNavigationController = UINavigationController(rootViewController: filmCardViewContoller)

        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = filmsNavigationController
        window?.makeKeyAndVisible()
        
        return true

    }


}

//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = FilmsViewController()
//        window?.makeKeyAndVisible()
//
//        return true
//
//    }
//
//
//}
