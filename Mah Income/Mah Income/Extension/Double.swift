//
//  Double.swift
//  Mah Income
//
//  Created by Van Luu on 5/8/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation

extension Double {
  /// Rounds the double to decimal places value
  func roundTo(places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
