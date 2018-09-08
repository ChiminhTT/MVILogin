//
//  LoginViewReactor.swift
//  MVILogin
//
//  Created by maxence on 08/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import RxSwift

final class LoginViewReactor: Reactor
{
  enum Action
  {
    case display_ui_state(LoginUIState)
    case update_email(String?)
    case update_password(String?)
  }
  
  enum Mutation
  {
    case change_ui_state(LoginUIState)
    case change_email(String?)
    case change_password(String?)
    case update_info_validity
  }
  
  struct State
  {
    var ui_state: LoginUIState = .launch
    var email: String?
    var password: String?
    var info_validity: Bool = false
  }
  
  let initialState: State = State()
}

extension LoginViewReactor
{
  func mutate(action: Action) -> Observable<Mutation>
  {
    switch action
    {
    case .display_ui_state(let ui_state):
      return Observable.just(.change_ui_state(ui_state))
    case .update_email(let new_email):
      return Observable.concat([
        Observable.just(.change_email(new_email)),
        Observable.just(.update_info_validity)
      ])
    case .update_password(let new_password):
      return Observable.concat([
        Observable.just(.change_password(new_password)),
        Observable.just(.update_info_validity)
      ])
    }
  }
  
  func reduce(state: State,
              mutation: Mutation) -> State
  {
    var new_state = state
    switch mutation
    {
    case .change_ui_state(let new_ui_state):
      new_state.ui_state = new_ui_state
    case .change_email(let new_email):
      new_state.email = new_email
    case .change_password(let new_password):
      new_state.password = new_password
    case .update_info_validity:
      new_state.info_validity = check_info_validity(new_state)
    }
    return new_state
  }
}

private func check_info_validity(_ state: LoginViewReactor.State) -> Bool
{
  guard
    let email = state.email,
    let password = state.password
  else { return false }
  return email.count > 5 && password.count > 5
}
