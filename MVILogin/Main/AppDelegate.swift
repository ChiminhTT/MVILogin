//
//  AppDelegate.swift
//  MVILogin
//
//  Created by maxence on 07/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
  {
    // Override point for customization after application launch.
    self.window = UIWindow(frame: UIScreen.main.bounds)
    
    let storyboard = UIStoryboard(name: Storyboard.login.rawValue, bundle: nil)
    let login_vc = storyboard.instantiateViewController(withIdentifier: ViewIdentifier.login_vc.rawValue) as? LoginViewController
    _ = login_vc?.view
    
    let login_reactor = LoginViewReactor()
    login_vc?.reactor = login_reactor
    
    if let login_vc = login_vc
    {
      self.window?.rootViewController = login_vc
      self.window?.makeKeyAndVisible()
    }
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {}

  func applicationDidEnterBackground(_ application: UIApplication) {}

  func applicationWillEnterForeground(_ application: UIApplication) {}

  func applicationDidBecomeActive(_ application: UIApplication) {}

  func applicationWillTerminate(_ application: UIApplication) {}
}

