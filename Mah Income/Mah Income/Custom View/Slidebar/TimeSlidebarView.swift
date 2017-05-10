//
//  TimeSlidebarView.swift
//  Mah Income
//
//  Created by Van Luu on 5/9/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

protocol TimeSliderbarViewDelegate: class {
  func didStartChangingValue(timesSliderbar: TimeSlidebarView, newValue: Int, kind: TimeSlidebarView.Kind)
}

@IBDesignable
class TimeSlidebarView: UIView {
  
  enum Kind {
    case week
    case month
    case year
    
    var text: String {
      switch self {
      case .week:
        return "weeks"
      case .month:
        return "months"
      case .year:
        return "years"
      }
    }
    
    var component: Calendar.Component {
      switch self {
      case .week:
        return .weekOfYear
      case .month:
        return .month
      case .year:
        return .year
      }
    }
  }
  
  @IBInspectable var min: Int {
    get {
      return Int(slider.minimumValue)
    }
    set {
      slider.minimumValue = Float(newValue)
    }
  }
  
  @IBInspectable var max: Int {
    get {
      return Int(slider.maximumValue)
    }
    set {
      slider.maximumValue = Float(newValue)
    }
  }
  
  var kind: Kind = .week {
    didSet {
      numberLabel.text = "Last \(Int(slider.value)) \(kind.text)"
    }
  }
  
  var isEnable: Bool = true {
    didSet {
      numberLabel.textColor = isEnable ? UIColor.white : AppColor.TimeSliderbar.disable
      slider.tintColor = isEnable ? AppColor.TimeSliderbar.enabled : AppColor.TimeSliderbar.disable
    }
  }
  
  weak var delegate: TimeSliderbarViewDelegate!
  
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  
  @IBAction func handleSliderValueChanged(_ sender: UISlider) {
    numberLabel.text = "Last \(Int(slider.value)) \(kind.text)"
    delegate.didStartChangingValue(timesSliderbar: self, newValue: Int(slider.value), kind: kind)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    let nibView = UINib(nibName: "TimeSlidebarView", bundle: nil)
    let view = nibView.instantiate(withOwner: self, options: nil)[0] as! UIView
    view.frame = self.bounds
    self.addSubview(view)
  }
  
  
}
