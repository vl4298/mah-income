//
//  UIStoryboard.swift
//  Mah Income
//
//  Created by Van Luu on 4/15/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

extension UIStoryboard {
  func instantiateViewController<T:UIViewController>(type: T.Type) -> T? {
    var fullName: String = NSStringFromClass(T.self)
    if let range = fullName.range(of: ".", options: .backwards) {
      fullName = fullName.substring(from: range.upperBound)
    }
    return self.instantiateViewController(withIdentifier: fullName) as? T
  }
}
