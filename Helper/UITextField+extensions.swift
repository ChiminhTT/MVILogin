//
//  UITextField+extensions.swift
//  MVILogin
//
//  Created by maxence on 08/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import UIKit

extension UITextField
{
  @IBInspectable var placeHolderColor: UIColor?
  {
    get
    {
      return self.placeHolderColor
    }
    set
    {
      self.attributedPlaceholder =
        NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                           attributes:[NSAttributedStringKey.foregroundColor: newValue!])
    }
  }
}
