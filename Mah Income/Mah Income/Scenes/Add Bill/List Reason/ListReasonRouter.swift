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
  
  func addAddReasonScene() {
    let addReasonVC = viewController.storyboard!.instantiateViewController(type: AddReasonViewController.self)!
    AddReasonConfigurator.sharedInstance.configure(viewController: addReasonVC)
    
    viewController.addChildViewController(addReasonVC)
    viewController.view.addSubview(addReasonVC.view)
    
    let transform1 = CGAffineTransform(translationX: viewController.view.frame.width, y: 0)
    let transform2 = CGAffineTransform(translationX: -viewController.view.frame.width, y: 0)
    
    addReasonVC.view.frame = viewController.view.frame
    addReasonVC.view.transform = transform1
    UIView.animate(withDuration: 0.5, animations: {
      self.viewController.view.transform = transform2
    }, completion: { _ in
      addReasonVC.view.transform = CGAffineTransform.identity
      self.viewController.view.transform = CGAffineTransform.identity
      addReasonVC.didMove(toParentViewController: self.viewController)
    })
  }
  
}
