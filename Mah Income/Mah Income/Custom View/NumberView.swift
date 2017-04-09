//
//  NumberView.swift
//  Manage Money
//
//  Created by Van Luu on 20/08/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

import UIKit


@objc protocol NumberDelegate {
  func numberTapped(_ number: Int)
}

@IBDesignable
class NumberView: UIView {
  
  @IBOutlet var delegate: NumberDelegate?
  
  var numberLabel: UILabel?
  var numberButton: UIButton?
  
  var number: Int = -1 {
    didSet {
      numberButton?.setTitle("\(number)", for: UIControlState())
    }
  }
  
  var label: String = "" {
    didSet {
      numberButton?.setTitle(label, for: UIControlState())
    }
  }
  
  @IBInspectable var lineWidth: CGFloat = 4.0
  @IBInspectable var fillColor: UIColor = UIColor.red
  @IBInspectable var strokeColor: UIColor = UIColor.blue
  
  override func draw(_ rect: CGRect) {
    let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
    let path = UIBezierPath(ovalIn: insetRect)
    path.lineWidth = lineWidth
    
    fillColor.setFill()
    path.fill()
    
    strokeColor.setStroke()
    path.stroke()
  }
  
  override func awakeFromNib() {
    setup2()
  }
  
  override func prepareForInterfaceBuilder() {
    setup2()
  }
  
  func setup2() {
    numberButton = UIButton(type: .custom)
    numberButton?.frame = bounds
    guard let numberButton = numberButton else { return }
    numberButton.layer.cornerRadius = (bounds.width / 2) - lineWidth
    numberButton.setTitleColor(UIColor.darkText, for: UIControlState())
    numberButton.setTitleColor(UIColor.white, for: .highlighted)
    numberButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
    addSubview(numberButton)
    
    numberButton.translatesAutoresizingMaskIntoConstraints = false
    numberButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
    numberButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    numberButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    numberButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    numberButton.addTarget(self, action: #selector(touchInside(_:)), for: .touchDown)
    numberButton.addTarget(self, action: #selector(touchExit(_:)), for: .touchUpInside)
  }
  
  func touchInside(_ sender: UIButton) {
    UIView.animate(withDuration: 0.2, animations: {
      sender.backgroundColor = UIColor.green
    })
    
    if number == -1 {
      delegate?.numberTapped(-1) // backspace
      return
    }
    delegate?.numberTapped(number)
  }
  
  func touchExit(_ sender: UIButton) {
    UIView.animate(withDuration: 0.2, animations: {
      sender.backgroundColor = UIColor.clear
    })
  }
  
}
