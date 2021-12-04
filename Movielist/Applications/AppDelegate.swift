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
//        let filmCardNavigationController = UINavigationController(rootViewController: )

        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = filmsNavigationController
        window?.makeKeyAndVisible()
        
        return true

    }


}
