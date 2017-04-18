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
  
  func presentListReasonScene() {
    let listReasonVC = viewController.storyboard!.instantiateViewController(type: ListReasonViewController.self)!
    ListReasonConfigurator.sharedInstance.configure(viewController: listReasonVC)
    
    listReasonVC.delegate = viewController
    
    viewController.present(listReasonVC, animated: true, completion: nil)
  }
  
}
