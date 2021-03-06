//
//  LoginViewController+Helper.swift
//  MVILogin
//
//  Created by maxence on 08/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import UIKit

enum LoginUIState: Equatable
{
  case launch
  case landing
  case typing
  case login_loading
  case login_succeeded
  case login_failed
}

func ==(lhs: LoginUIState, rhs: LoginUIState) -> Bool
{
  switch (lhs, rhs)
  {
  case (.launch, .launch):
    return true
  case (.landing, .landing):
    return true
  case (.typing, .typing):
    return true
  case (.login_loading, .login_loading):
    return true
  case (.login_succeeded, .login_succeeded):
    return true
  case (.login_failed, .login_failed):
    return true
  default:
    return false
  }
}


struct LoginUI
{
  let icon_top_constraint: CGFloat
  let icon_to_email_constraint: CGFloat
  let button_bottom_constraint: CGFloat
  let button_side_constraint: CGFloat
  let email_textfield_alpha: CGFloat
  let password_textfield_alpha: CGFloat
  let login_button_alpha: CGFloat
  let button_corner_radius: CGFloat
  let button_login_status: LoadingState?
}

extension LoginViewController
{
  func setup_textfields()
  {
    email_textfield.layer.add_border(edge: .bottom,
                                     color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.55),
                                     thickness: CGFloat(1),
                                     width: CGFloat(password_textfield.frame.width))
    password_textfield.layer.add_border(edge: .bottom,
                                        color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.55),
                                        thickness: CGFloat(1),
                                        width: CGFloat(password_textfield.frame.width))
  }
  
  func load_layout(corresponding login_ui_state: LoginUIState, animated: Bool)
  {
    let login_ui = getLoginUI(state: login_ui_state)
    if animated
    {
      UIView.animate(
        withDuration: 0.5,
        delay: 0.3,
        options: .curveEaseInOut,
        animations: {
          self.icon_top_constraint.constant = login_ui.icon_top_constraint
          self.icon_to_email_constraint.constant = login_ui.icon_to_email_constraint
          self.button_bottom_constraint.constant = login_ui.button_bottom_constraint
          self.button_side_constraint.constant = login_ui.button_side_constraint
          self.view.layoutIfNeeded()
          self.email_textfield.alpha = login_ui.email_textfield_alpha
          self.password_textfield.alpha = login_ui.password_textfield_alpha
          self.login_button.alpha = login_ui.password_textfield_alpha
          self.login_button.layer.cornerRadius = login_ui.button_corner_radius
          if let loading_status = login_ui.button_login_status
          {
            self.login_button.loading_status = loading_status
          }
      })
    }
    else
    {
      self.icon_top_constraint.constant = login_ui.icon_top_constraint
      self.icon_to_email_constraint.constant = login_ui.icon_to_email_constraint
      self.button_bottom_constraint.constant = login_ui.button_bottom_constraint
      self.button_side_constraint.constant = login_ui.button_side_constraint
      self.view.layoutIfNeeded()
      self.email_textfield.alpha = login_ui.email_textfield_alpha
      self.password_textfield.alpha = login_ui.password_textfield_alpha
      self.login_button.alpha = login_ui.password_textfield_alpha
      self.login_button.layer.cornerRadius = login_ui.button_corner_radius
    }
  }
}

extension LoginViewController
{
  private func getLoginUI(state: LoginUIState) -> LoginUI
  {
    switch state
    {
    case .launch:
      return LoginUI(
        icon_top_constraint: CGFloat(view.frame.height/2 - icon_imageview.frame.height),
        icon_to_email_constraint: CGFloat(40),
        button_bottom_constraint: CGFloat(20),
        button_side_constraint: CGFloat(24),
        email_textfield_alpha: 0,
        password_textfield_alpha: 0,
        login_button_alpha: 0,
        button_corner_radius: 5,
        button_login_status: nil
      )
    case .landing, .login_succeeded, .login_failed:
      return LoginUI(
        icon_top_constraint: CGFloat(70),
        icon_to_email_constraint: CGFloat(90),
        button_bottom_constraint: CGFloat(190),
        button_side_constraint: CGFloat(24),
        email_textfield_alpha: 1,
        password_textfield_alpha: 1,
        login_button_alpha: 1,
        button_corner_radius: 5,
        button_login_status: nil
      )
    case .typing:
      return LoginUI(
        icon_top_constraint: CGFloat(20),
        icon_to_email_constraint: CGFloat(70),
        button_bottom_constraint: CGFloat(keyboard_height),
        button_side_constraint: CGFloat(0),
        email_textfield_alpha: 1,
        password_textfield_alpha: 1,
        login_button_alpha: 1,
        button_corner_radius: 0,
        button_login_status: nil
      )
    case .login_loading:
      return LoginUI(
        icon_top_constraint: CGFloat(20),
        icon_to_email_constraint: CGFloat(70),
        button_bottom_constraint: CGFloat(keyboard_height),
        button_side_constraint: CGFloat(0),
        email_textfield_alpha: 1,
        password_textfield_alpha: 1,
        login_button_alpha: 1,
        button_corner_radius: 0,
        button_login_status: .loading
      )
    }
  }
}
