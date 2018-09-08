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

class LoginViewController: UIViewController
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
  
  // MARK: - Instance parameter
  let disposeBag = DisposeBag()
}

extension LoginViewController
{
  override func viewDidLoad()
  {
    load_layout(corresponding: .launch, animated: false)
    keyboardHeight()
      .drive(onNext: { [unowned self] (value, animation_duration) in
        print(value)
        DispatchQueue.main.async {
          self.load_layout(corresponding: .typing(keyboard_height: value), animated: true)
        }
      })
      .disposed(by: disposeBag)
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    setup_textfields()
    load_layout(corresponding: .landing, animated: true)
  }
}

