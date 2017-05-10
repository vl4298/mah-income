//
//  AnalyzeConfigurator.swift
//  Mah Income
//
//  Created by Van Luu on 5/8/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class AnalyzeConfigurator {
  
  static let sharedInstance = AnalyzeConfigurator()
  
  private init(){}
  
  func configure(viewController: AnalyzeViewController) {
    let router = AnalyzeRouter()
    
    router.viewController = viewController
    viewController.router = router
    
    let modelController = AnalyzeModelController()
    modelController.viewController = viewController
    viewController.modelController = modelController
  }
  
}
