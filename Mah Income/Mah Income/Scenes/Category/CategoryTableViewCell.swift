//
//  CategoryTableViewCell.swift
//  Mah Income
//
//  Created by Van Luu on 4/27/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

protocol CategoryTableViewCellDelegate: class {
  func didSelectEdit(category: CategoryModel)
  func didSelectDelete(category: CategoryModel)
}

class CategoryTableViewCell: UITableViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var containerViewRightConstrainst: NSLayoutConstraint!
  @IBOutlet weak var containerViewLeftConstrainst: NSLayoutConstraint!
  @IBOutlet weak var buttonStackView: UIStackView!
  
  weak var delegate: CategoryTableViewCellDelegate!
  var category: CategoryModel!
  
  var panStartPoint: CGPoint = CGPoint.zero
  var startingRightLayoutConstrainst: CGFloat = 0.0
  let kBounceValue: CGFloat = 20.0
  var panningLeft = false
  var constantRight: CGFloat = 0
  var constantLeft: CGFloat = 0
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
    containerView.addGestureRecognizer(panGesture)
  }
  
  @IBAction func handleButton(sender: UIButton) {
    if sender.tag == 10 { // delete
      delegate.didSelectDelete(category: category)
    } else {
      delegate.didSelectEdit(category: category)
    }
    
    self.resetConstrainstToZero(animated: false, notifyDelegateDidClose: false)
  }
  
  func configure(category: CategoryModel) {
    self.category = category
    
    categoryLabel.text = category._name
  }
  
  func handlePanGesture(gesture: UIPanGestureRecognizer) {
    switch gesture.state {
    case .began:
      panStartPoint = gesture.translation(in: self.containerView)
      startingRightLayoutConstrainst = containerViewRightConstrainst.constant
    //      print("Pan began at: \(panStartPoint)")
    case .changed:
      let currentPoint = gesture.translation(in: self.containerView)
      let deltaX = currentPoint.x - panStartPoint.x
      
      if currentPoint.x < panStartPoint.x {
        panningLeft = true
      } else {
        panningLeft = false
      }
      
      panStartPoint = currentPoint
      
      constantRight = containerViewRightConstrainst.constant
      constantLeft = containerViewLeftConstrainst.constant
      
      if panningLeft {
        containerViewRightConstrainst.constant = constantRight + -deltaX
        containerViewLeftConstrainst.constant = deltaX + constantLeft
      } else {
        containerViewRightConstrainst.constant = constantRight - deltaX
        containerViewLeftConstrainst.constant = deltaX + constantLeft
      }
      
      
    case .ended:
      
      if panningLeft {
        
        if constantRight > buttonTotalWidth() {
          setConstrainstToShowAllButton(animated: true, notifyDelegateDidOpen: false)
        } else {
          resetConstrainstToZero(animated: true, notifyDelegateDidClose: false)
        }
        
      } else {
        
        if constantRight < 20.0 || constantRight > 20.0 {
          resetConstrainstToZero(animated: true, notifyDelegateDidClose: false)
        }
        
      }
      
    //      print("Pan moved: \(deltaX)")
    default:
      return
    }
  }
  
  func buttonTotalWidth() -> CGFloat {
    return buttonStackView.frame.width + 35
  }
  
  func resetConstrainstToZero(animated: Bool, notifyDelegateDidClose: Bool) {
    containerViewLeftConstrainst.constant = 20.0
    containerViewRightConstrainst.constant = 20.0
    
    updateConstraintsIfNeeded(animated: animated) { _ in
      
    }
  }
  
  func setConstrainstToShowAllButton(animated: Bool, notifyDelegateDidOpen: Bool) {

    containerViewLeftConstrainst.constant = -buttonTotalWidth()
    containerViewRightConstrainst.constant = buttonTotalWidth()
    
    updateConstraintsIfNeeded(animated: animated) { _ in
      
    }
  }
  
  func updateConstraintsIfNeeded(animated: Bool, completion: @escaping (Bool) -> Void) {
    var duration: TimeInterval = 0.0
    if animated {
      duration  = 0.3
    }
    
    UIView.animate(withDuration: duration, animations: {
      self.layoutIfNeeded()
    }, completion: completion)
  }
  
}
