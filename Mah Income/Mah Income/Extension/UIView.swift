//
//  UIView.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {
  
  @IBInspectable var cornerRadius: CGFloat {
    set {
      layer.cornerRadius = newValue
    } get {
      return layer.cornerRadius
    }
  }
  
}
