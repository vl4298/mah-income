//
//  CategoryConfigurator.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class CategoryConfigurator {
  
  static let sharedInstance = CategoryConfigurator()
  
  private init() {
    
  }
  
  func configure(viewController: CategoryViewController) {
    let router = CategoryRouter()
    
    router.viewController = viewController
    viewController.router = router
  }
}
