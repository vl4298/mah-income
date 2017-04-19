//
//  AddReasonRouter.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class AddReasonRouter {
  
  weak var viewController: AddReasonViewController!
  
  func transitionBackToListReason() {
    
    let transform1 = CGAffineTransform(translationX: viewController.view.frame.width, y: 0)
    let transform2 = CGAffineTransform(translationX: -viewController.view.frame.width, y: 0)
    
    self.viewController.parent!.view.transform = transform2
    self.viewController.view.transform = transform1
    
    viewController.willMove(toParentViewController: nil)
    UIView.animate(withDuration: 0.5, animations: {
      self.viewController.parent!.view.transform = CGAffineTransform.identity
    }, completion: { _ in
      self.viewController.parent!.view.transform = CGAffineTransform.identity
      self.viewController.view.removeFromSuperview()
      self.viewController.removeFromParentViewController()
    })
  }
  
}
