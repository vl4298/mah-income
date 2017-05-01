//
//  ListPaymentConfigurator.swift
//  Mah Income
//
//  Created by Van Luu on 5/1/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class ListPaymentConfigurator {
  
  static let sharedInstance = ListPaymentConfigurator()
  
  func configure(viewController: ListPaymentViewController) {
    
    let modelController = ListPaymentModelController()
    modelController.viewController = viewController
    viewController.modelController = modelController
    
  }
}
