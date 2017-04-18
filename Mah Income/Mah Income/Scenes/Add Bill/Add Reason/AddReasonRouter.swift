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
    
    viewController.willMove(toParentViewController: nil)
    UIView.transition(from: viewController.view, to: viewController.parent!.view, duration: 0.5, options: .transitionFlipFromRight, completion: { _ in
      self.viewController.view.removeFromSuperview()
      self.viewController.removeFromParentViewController()
    })
    
  }
  
}
