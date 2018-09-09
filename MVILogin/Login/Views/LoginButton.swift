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
import NVActivityIndicatorView

enum LoadingState
{
  case loading
  case iddle
}

class LoginButton: UIButton
{
  private let disposeBag = DisposeBag()
  var indicator_view = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20),
                                               type: NVActivityIndicatorType(rawValue: 2),
                                               color: #colorLiteral(red: 0.2274509804, green: 0.337254902, blue: 0.5137254902, alpha: 1))
  var loading_status: LoadingState = .iddle
  {
    didSet
    {
      switch loading_status
      {
      case .iddle:
        DispatchQueue.main.async {
          UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = .white
            self.setTitle("Log in", for: .normal)
          })
          self.indicator_view.stopAnimating()
        }
      case .loading:
        DispatchQueue.main.async {
          self.indicator_view.startAnimating()
          UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.2156862745, blue: 0.3254901961, alpha: 0.45)
            self.setTitle(nil, for: .normal)
          })
        }
      }
    }
  }
  
  override init(frame: CGRect)
  {
    super.init(frame: frame)
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
    layer.cornerRadius = 5
    setTitleColor(#colorLiteral(red: 0.3450980392, green: 0.2078431373, blue: 0.368627451, alpha: 1), for: .disabled)
    add_indicator_view()
  }
}

extension LoginButton
{
  override var isEnabled: Bool
  {
    didSet
    {
      let background_color = isEnabled ? .white : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.55)
      UIView.animate(withDuration: 0.2, animations: {
        self.backgroundColor = background_color
      })
    }
  }
  
  override var isHighlighted: Bool
  {
    didSet
    {
      let background_color = isHighlighted ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.75) : .white
      UIView.animate(withDuration: 0.2, animations: {
        self.backgroundColor = background_color
      })
    }
  }
}

extension LoginButton
{
  private func add_indicator_view()
  {
    let indicator_size = self.frame.height * 0.7
    let indicator_frame =
      CGRect(
        origin: CGPoint(x: self.frame.width/2 - indicator_size/2, y: self.frame.height/2 - indicator_size/2),
        size: CGSize(width: indicator_size, height: indicator_size)
      )
    indicator_view = NVActivityIndicatorView(frame: indicator_frame,
                                             type: NVActivityIndicatorType(rawValue: 2),
                                             color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5500000119))
    addSubview(indicator_view)
  }
}
