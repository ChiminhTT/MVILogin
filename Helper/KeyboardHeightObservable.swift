//
//  KeyboardHeightObservable.swift
//  MVILogin
//
//  Created by maxence on 08/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

typealias KeyboardHeightInfo = (CGFloat, TimeInterval)

func keyboardHeight() -> Driver<KeyboardHeightInfo>
{
  return Observable
    .from([
      NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillShow)
        .map { notification -> KeyboardHeightInfo in
          let userInfo = notification.userInfo
          let value = (userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
          let animationDuration = userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
          return (value, animationDuration)
      },
      NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillHide)
        .map { notification -> KeyboardHeightInfo in
          let userInfo = notification.userInfo
          let animationDuration = userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
          return (0, animationDuration)
      }
      ])
    .merge()
    .asDriver(onErrorDriveWith: Driver.never())
}
