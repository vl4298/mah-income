//
//  PaddingTextField.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

@IBDesignable
class PaddingTextField: UITextField {
  
  @IBInspectable var paddingLeft: CGFloat = 0.0 {
    didSet {
      if let leftView = self.leftView {
        leftView.frame.size = CGSize(width: paddingLeft, height: self.bounds.height)
        layoutSubviews()
      }
    }
  }
  
  @IBInspectable var paddingRight: CGFloat = 0.0 {
    didSet {
      if let rightView = self.rightView {
        rightView.frame.size = CGSize(width: paddingRight, height: self.bounds.height)
        layoutSubviews()
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  func setupView() {
    let paddingLeftView = UIView(frame: CGRect(x: 0, y: 0, width: paddingLeft, height: self.bounds.height))
    self.leftView = paddingLeftView
    self.leftViewMode = .always
    
    let paddingRightView = UIView(frame: CGRect(x: 0, y: 0, width: paddingRight, height: self.bounds.height))
    self.rightView = paddingRightView
    self.rightViewMode = .always
  }
  
}
