//
//  LoginButton.swift
//  MVILogin
//
//  Created by maxence on 08/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginButton: UIButton
{
  let btn_state = Variable(true)
  private let disposeBag = DisposeBag()
  
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    btn_state
      .asObservable()
      .bind(to: self.rx.isEnabled)
      .disposed(by: disposeBag)
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
  }
}

extension LoginButton
{
  override func awakeFromNib()
  {
    bind()
    layer.cornerRadius = 5
    setTitleColor(#colorLiteral(red: 0.3450980392, green: 0.2078431373, blue: 0.368627451, alpha: 1), for: .disabled)
  }
}

extension LoginButton
{
  private func bind()
  {
    btn_state
      .asObservable()
      .subscribe({ event in
        guard let isEnabled = event.element else { return }
        isEnabled ? (self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.55)) : (self.backgroundColor = .white)
      })
      .disposed(by: disposeBag)
  }
}
