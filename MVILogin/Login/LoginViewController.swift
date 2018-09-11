//
//  LaunchViewController.swift
//  MVILogin
//
//  Created by maxence on 07/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NVActivityIndicatorView

final class LoginViewController: UIViewController, View
{
  // MARK: - IBOutlets
  @IBOutlet weak var icon_imageview: UIImageView!
  @IBOutlet weak var email_textfield: UITextField!
  @IBOutlet weak var password_textfield: UITextField!
  @IBOutlet weak var login_button: LoginButton!
  @IBOutlet weak var icon_top_constraint: NSLayoutConstraint!
  @IBOutlet weak var icon_to_email_constraint: NSLayoutConstraint!
  @IBOutlet weak var button_bottom_constraint: NSLayoutConstraint!
  @IBOutlet weak var button_side_constraint: NSLayoutConstraint!
  
  var indicator_view: NVActivityIndicatorView?
  var keyboard_height: CGFloat = 0
  // MARK: - Instance parameter
  var disposeBag = DisposeBag()
}

extension LoginViewController
{
  func bind(reactor: LoginViewReactor)
  {
    /// View to reactor
    self.rx
      .viewDidAppear
      .map { _ in Reactor.Action.display_ui_state(.landing) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    keyboardHeight().asObservable()
      .map {(value, _) in
        self.keyboard_height = value
        return Reactor.Action.display_ui_state(.typing)
      }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    email_textfield.rx
      .text
      .throttle(0.2, scheduler: MainScheduler.instance)
      .map { Reactor.Action.update_email($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    password_textfield.rx
      .text
      .throttle(0.2, scheduler: MainScheduler.instance)
      .map { Reactor.Action.update_password($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    login_button.rx
      .tap
      .map
      {
        Reactor.Action.login(email: self.email_textfield.text,
                             password: self.password_textfield.text)
      }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    
    /// Reactor to view
    reactor.state
      .map { $0.ui_state }
      .subscribe(onNext: { ui_state in
        switch ui_state
        {
        case .launch:
          self.load_layout(corresponding: .launch, animated: false)
          self.setup_textfields()
        case .login_loading:
          self.load_layout(corresponding: .login_loading, animated: true)
        default:
          self.load_layout(corresponding: ui_state, animated: true)
        }
      })
      .disposed(by: disposeBag)
    
    reactor.state
      .map { $0.info_validity }
      .bind(to: login_button.rx.isEnabled)
      .disposed(by: disposeBag)
  }
}
