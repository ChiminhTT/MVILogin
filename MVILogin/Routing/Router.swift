//
//  Router.swift
//  MVILogin
//
//  Created by maxence on 08/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import UIKit

enum Storyboard: String
{
  case login = "Login"
}

enum ViewIdentifier: String
{
  case login_vc = "login_vc"
  case home_vc = "home_vc"
}

enum Route
{
  case login
  case home
}

class Router
{
  static func route(from origin_vc: UIViewController, to destination: Route)
  {
    let opt_target_vc: UIViewController?
    switch destination
    {
    case .login:
      let storyboard = UIStoryboard(name: Storyboard.login.rawValue, bundle: nil)
      opt_target_vc =
        storyboard.instantiateViewController(
          withIdentifier: ViewIdentifier.login_vc.rawValue
        ) as? LoginViewController
    case .home:
      let storyboard = UIStoryboard(name: Storyboard.login.rawValue, bundle: nil)
      opt_target_vc =
        storyboard.instantiateViewController(
          withIdentifier: ViewIdentifier.home_vc.rawValue
        )
    }
    
    guard
      let target_vc = opt_target_vc
    else { return }
    origin_vc.present(target_vc, animated: true, completion: nil)
  }
}
