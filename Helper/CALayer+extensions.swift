//
//  UITextField+extensions.swift
//  MVILogin
//
//  Created by maxence on 08/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import UIKit

extension CALayer
{
  func add_border(edge: UIRectEdge,
                  color: UIColor,
                  thickness: CGFloat,
                  width: CGFloat)
  {
    let border = CALayer()
    switch edge
    {
    case UIRectEdge.top:
      border.frame = CGRect(
        x: 0,
        y: -1,
        width: width,
        height: thickness
      )
      break
    case UIRectEdge.bottom:
      border.frame = CGRect(
        x: 0,
        y: self.bounds.height - thickness + 1,
        width: width,
        height: thickness
      )
      break
    case UIRectEdge.left:
      border.frame = CGRect(
        x: 0,
        y: 0,
        width: thickness,
        height: self.bounds.height
      )
    case UIRectEdge.right:
      border.frame = CGRect(
        x: width - thickness,
        y: 0,
        width: thickness,
        height: self.bounds.height
      )
    default:
      break
    }
    border.backgroundColor = color.cgColor
    
    self.addSublayer(border)
  }
}
