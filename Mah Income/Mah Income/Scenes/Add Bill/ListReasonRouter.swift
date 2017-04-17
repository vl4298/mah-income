//
//  ListReasonRouter.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class ListReasonRouter {
  
  weak var viewController: ListReasonViewController!
  
  func presentAddReasonScene() {
    let addReasonVC = viewController.storyboard!.instantiateViewController(type: AddReasonViewController.self)!
    AddReasonConfigurator.sharedInstance.configure(viewController: addReasonVC)
    
    viewController.addChildViewController(addReasonVC)
    
    addReasonVC.view.frame = viewController.view.frame
    viewController.view.addSubview(addReasonVC.view)
    UIView.transition(from: viewController.view, to: addReasonVC.view, duration: 0.5, options: .transitionFlipFromLeft, completion: { _ in
      addReasonVC.didMove(toParentViewController: self.viewController)
    })
  }
  
}
