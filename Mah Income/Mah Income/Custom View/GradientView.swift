//
//  GradientView.swift
//  Mah Income
//
//  Created by Van Luu on 4/18/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
  
  @IBInspectable var startColor: UIColor = UIColor.darkGray
  @IBInspectable var endColor: UIColor = UIColor.clear
  
  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    let colors = [startColor.cgColor, endColor.cgColor]
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    let colorLocations: [CGFloat] = [0.0, 1.0]
    
    let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)
    
    let startPoint = CGPoint(x: 0, y: rect.midY)
    let endPoint = CGPoint(x: rect.width, y: rect.midY)
    context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
  }
  
}
