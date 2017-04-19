//
//  AddPaymentRouter.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class AddPaymentRouter {
  
  weak var viewController: AddPaymentViewController!
  lazy var animator = LinearTransitionAnimator(duration: 0.5, direction: .right)
  
  func presentListReasonScene() {
    let listReasonVC = viewController.storyboard!.instantiateViewController(type: ListReasonViewController.self)!
    ListReasonConfigurator.sharedInstance.configure(viewController: listReasonVC)
    
    listReasonVC.delegate = viewController
    listReasonVC.transitioningDelegate = animator
    
    viewController.present(listReasonVC, animated: true, completion: nil)
  }
  
  func dismissListReasonScene() {
    viewController.dismiss(animated: true, completion: nil)
  }
  
}
