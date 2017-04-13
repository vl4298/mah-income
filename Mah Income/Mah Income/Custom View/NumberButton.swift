

import UIKit

@IBDesignable
class NumberButton: UIButton {
  
  var normalColor: UIColor = AppColor.NumberButton.numberButtonColor {
    didSet {
      backgroundColor = normalColor
    }
  }
  
  var textColor: UIColor = AppColor.NumberButton.numberButtonTextColor {
    didSet {
      setTitleColor(textColor, for: .normal)
    }
  }
  
  var hightlightTextColor: UIColor = AppColor.NumberButton.numberButtonHightlightTextColor {
    didSet {
      setTitleColor(hightlightTextColor, for: .highlighted)
    }
  }
  
  fileprivate let durationAnimation: TimeInterval = 0.2
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    self.setTitleColor(self.hightlightTextColor, for: .normal)
    
    UIView.animate(withDuration: durationAnimation, animations: {
      self.backgroundColor = AppColor.mainColor
    }, completion: { _ in
    })
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    self.setTitleColor(self.textColor, for: .normal)
    
    UIView.animate(withDuration: durationAnimation, animations: {
      self.backgroundColor = AppColor.NumberButton.numberButtonColor
    }, completion: { _ in
      
    })
  }
  
  
}

extension NumberButton {
  func setupView() {
    let smallerSize = min(bounds.width, bounds.height)
    
    layer.cornerRadius = smallerSize/2
    backgroundColor = normalColor
    setTitleColor(textColor, for: .normal)
    setTitleColor(hightlightTextColor, for: .highlighted)
    titleLabel?.font = Font.font
    titleLabel?.adjustsFontSizeToFitWidth = true

  }
}
