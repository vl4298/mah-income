//
//  AddPaymentConfigurator.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class AddPaymentConfigurator {
  
  static let sharedInstance = AddPaymentConfigurator()
  
  func configure(viewController: AddPaymentViewController) {
    
    let router = AddPaymentRouter()
    
    router.viewController = viewController
    viewController.router = router
  }
}
