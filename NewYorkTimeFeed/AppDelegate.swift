//
//  AppDelegate.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 09/06/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.configureWithTransparentBackground()
      navBarAppearance.backgroundColor = UIColor(red:0.0/255.0,green:73.0/255.0,blue:116.0/255.0,alpha:1.0)
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      UINavigationBar.appearance().standardAppearance = navBarAppearance
      UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let feedsListVC = storyboard.instantiateViewController(withIdentifier: "FeedsListVC")
    let nvc: UINavigationController  = UINavigationController(rootViewController: feedsListVC)
    self.window?.rootViewController = nvc
    
    self.window?.makeKeyAndVisible()
    return true
  }
}

