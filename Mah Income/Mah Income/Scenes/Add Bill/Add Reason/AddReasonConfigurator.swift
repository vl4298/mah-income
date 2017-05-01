//
//  AddReasonConfigurator.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class AddReasonConfigurator {
  
  static let sharedInstance = AddReasonConfigurator()
  
  private init() {
    
  }
  
  func configure(viewController: AddReasonViewController) {
    let router = AddReasonRouter()
    
    router.viewController = viewController
    viewController.router = router
    
    let modelController = AddReasonModelController()
    modelController.viewController = viewController
    viewController.modelController = modelController
  }
  
}
