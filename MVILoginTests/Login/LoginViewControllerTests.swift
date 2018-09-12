//
//  test.swift
//  MVILoginTests
//
//  Created by maxence on 12/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import XCTest

class LoginViewControllerTests: XCTestCase
{  
  /// View -> Reactor
  func test_action_login()
  {
    // 1. prepare a view with a stub reactor
    let view_controller = LoginViewController()
    
    view_controller.email_textfield.text = "test_email"
    view_controller.password_textfield.text = "test_password"
    
    // 2. prepare a stub reactor
    let reactor = LoginViewReactor()
    reactor.stub.isEnabled = true
    view_controller.reactor = reactor
    
    // 3. send an user interaction programatically
    view_controller.login_button.sendActions(for: .touchUpInside)
    
    // 4. assert actions
    switch reactor.stub.actions.last!
    {
    case .login(let email, let  password):
      XCTAssert(email == "test_email" && password == "test_password")
    default:
      XCTFail()
    }
  }
  
  func test_action_email_typing() {}
  func test_action_password_typing() {}

  /// Reactor -> View
  func test_state_landing()
  {
    // 1. prepare a stub reactor
    let reactor = LoginViewReactor()
    reactor.stub.isEnabled = true
    
    // 2. prepare a view with a stub reactor
    let view_controller = LoginViewController()
    view_controller.reactor = reactor
    
    // 3. set a stub state
    reactor.stub.state.value =
      LoginViewReactor.State(
        ui_state: .landing,
        email: nil,
        password: nil,
        info_validity: false
      )
    
    // 4. assert view properties
    XCTAssert(view_controller.icon_top_constraint.constant == CGFloat(70))
    XCTAssert(view_controller.icon_to_email_constraint.constant == CGFloat(90))
    XCTAssert(view_controller.button_bottom_constraint.constant == CGFloat(190))
    XCTAssert(view_controller.button_side_constraint.constant == CGFloat(24))
    XCTAssert(view_controller.email_textfield.alpha == 1)
    XCTAssert(view_controller.password_textfield.alpha == 1)
    XCTAssert(view_controller.login_button.alpha == 1)
    XCTAssert(view_controller.login_button.layer.cornerRadius ==  5)
    XCTAssert(view_controller.login_button.loading_status == .iddle)
  }
  
  func test_state_launch() {}
  func test_state_typing() {}
  func test_state_login_loading() {}
  func test_state_login_succeeded() {}
  func test_state_login_failed() {}
  func test_state_invalid_login_info() {}
  func test_state_valid_login_info() {}
}
