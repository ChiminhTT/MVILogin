//
//  LoginViewReactor.swift
//  MVILoginTests
//
//  Created by maxence on 12/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import XCTest

class LoginViewReactorTests: XCTestCase
{
  func test_display_ui_state()
  {
    let reactor = LoginViewReactor()
    reactor.action.onNext(.display_ui_state(.launch))
    XCTAssert(reactor.currentState.ui_state == .launch)
    
    reactor.action.onNext(.display_ui_state(.landing))
    XCTAssert(reactor.currentState.ui_state == .landing)
    
    reactor.action.onNext(.display_ui_state(.landing))
    XCTAssert(reactor.currentState.ui_state == .landing)
    
    reactor.action.onNext(.display_ui_state(.landing))
    XCTAssert(reactor.currentState.ui_state == .landing)
    
    reactor.action.onNext(.display_ui_state(.landing))
    XCTAssert(reactor.currentState.ui_state == .landing)
  }
  
  func test_update_email()
  {
    let reactor = LoginViewReactor()
    reactor.action.onNext(.update_email("test_email"))
    XCTAssert(reactor.currentState.email == "test_email")
  }
  
  func test_update_password() {}
  
  func test_info_validity()
  {
    let reactor = LoginViewReactor()
    
    XCTAssert(reactor.currentState.info_validity == false)
    
    reactor.action.onNext(.update_email("test_email"))
    XCTAssert(reactor.currentState.info_validity == false)
    
    reactor.action.onNext(.update_password("test_password"))
    XCTAssert(reactor.currentState.info_validity == true)
  }
}
