//
//  PassthroughView.swift
//  Mah Income
//
//  Created by Van Luu on 4/16/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class PassthroughView: UIView {
  
  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    for subview in subviews {
      if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
        return true
      }
    }
    return false
  }
  
}
