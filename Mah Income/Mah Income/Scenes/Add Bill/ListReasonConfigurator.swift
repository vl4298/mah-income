//
//  ListReasonConfigurator.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class ListReasonConfigurator {
  
  static let sharedInstance = ListReasonConfigurator()
  
  private init() {
    
  }
  
  func configure(viewController: ListReasonViewController) {
    
    let router = ListReasonRouter()
    
    viewController.router = router
    router.viewController = viewController
  }
  
}
