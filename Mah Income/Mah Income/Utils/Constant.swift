//
//  Constant.swift
//  Mah Income
//
//  Created by Van Luu on 4/12/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import UIKit

struct AppColor {
  struct NumberButton {
    static let numberButtonColor = UIColor(rgb: 0x00796B)
    static let numberButtonHightlightColor = UIColor(rgb: 0x009688)
    static let numberButtonTextColor = UIColor.white
    static let numberButtonHightlightTextColor = UIColor.white
  }
  
  struct AddReasonButton {
    static let backgroundColor = UIColor(rgb: 0xF44336)
    static let shadowColor = UIColor(rgb: 0xC62828)
  }
  
  struct AddCancelReasonButton {
    static let enableColor = UIColor(rgb: 0x757575)
    static let enableShadowColor = UIColor(rgb: 0x424242)
    static let disableColor = UIColor(rgb: 0xBDBDBD)
    static let disableShadowColor = UIColor(rgb: 0x757575)
  }
  
  struct Menu {
    static let home = UIColor(rgb: 0xEEEEEE)
    static let addBill = UIColor(rgb: 0x009688)
    static let category = UIColor(rgb: 0x673AB7)
    static let analyze = UIColor(rgb: 0x9E9E9E)
    static let setting = UIColor(rgb: 0x795548)
  }
  
  struct TimeSliderbar {
    static let disable = UIColor(rgb: 0x9E9E9E)
    static let enabled = UIColor(rgb: 0x00695C)
  }
  
  static let mainColor = UIColor(rgb: 0xE0E0E0)
  static let menuButton = UIColor(rgb: 0xEEEEEE)
  static let menuButtonShadow = UIColor(rgb: 0xBDBDBD)
  
}


struct Font {
  static let font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
}
