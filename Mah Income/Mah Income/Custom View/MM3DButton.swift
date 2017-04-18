//
//  MM3DView.swift
//  Mah Income
//
//  Created by Van Luu on 4/13/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

@IBDesignable
class MM3DButton: UIButton {
  
  @IBInspectable var shadowColor: UIColor = UIColor.clear {
    didSet {
      layer.shadowColor = shadowColor.cgColor
    }
  }
  
  @IBInspectable var shadowOffset: CGSize = CGSize.zero {
    didSet {
      layer.shadowOffset = shadowOffset
    }
  }
  
  @IBInspectable var shadowOpacity: Float = 1.0 {
    didSet {
      layer.shadowOpacity = shadowOpacity
    }
  }
  
  @IBInspectable var shadowRadius: CGFloat = 0.0 {
    didSet {
      layer.shadowRadius = shadowRadius
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
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    layer.shadowOffset = CGSize(width: 0, height: 0)
    UIView.animate(withDuration: 0.05) {
      self.transform = CGAffineTransform(translationX: 0, y: self.shadowOffset.height)
    }
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    layer.shadowOffset = shadowOffset
    UIView.animate(withDuration: 0.05) {
      self.transform = CGAffineTransform.identity
    }
  }

}

extension MM3DButton {
  
  func setupView() {
    cornerRadius    = 10.0
    shadowOffset    = CGSize(width: 0, height: 5)
    shadowOpacity   = 1.0
    shadowRadius    = 0.0
  }

}
