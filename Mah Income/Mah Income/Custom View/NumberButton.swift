

import UIKit

class NumberButton: UIButton {
  
  fileprivate let durationAnimation: TimeInterval = 0.2
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    layoutView()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    UIView.animate(withDuration: durationAnimation, animations: {
      self.backgroundColor = AppColor.NumberButton.numberButtonHightlightColor
    }, completion: { _ in
    })
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
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
    backgroundColor = AppColor.NumberButton.numberButtonColor
    setTitleColor(AppColor.NumberButton.numberButtonTextColor, for: .normal)
    titleLabel?.font = Font.font
    titleLabel?.adjustsFontSizeToFitWidth = true

  }
  
  func layoutView() {
    let smallerSize = min(bounds.width, bounds.height)
    
    layer.cornerRadius = smallerSize/2
  }
  
  
}
