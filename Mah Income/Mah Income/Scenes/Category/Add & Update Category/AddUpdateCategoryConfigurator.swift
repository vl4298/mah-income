//
//  AddUpdateCategoryConfigurator.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class AddUpdateCategoryConfigurator {
  
  static let sharedInstance = AddUpdateCategoryConfigurator()
  
  private init() {
    
  }
  
  func configure(viewController: AddUpdateCategoryViewController) {
    let router = AddUpdateCategoryRouter()
    
    router.viewController = viewController
    viewController.router = router
  }
}
