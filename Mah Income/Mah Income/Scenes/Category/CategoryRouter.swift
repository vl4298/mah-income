//
//  CategoryRouter.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class CategoryRouter {
  
  weak var viewController: CategoryViewController!
  
  func addAddUpdateCategoryScene() {
    let addUpdateCategoryVC = viewController.storyboard!.instantiateViewController(type: AddUpdateCategoryViewController.self)!
    AddUpdateCategoryConfigurator.sharedInstance.configure(viewController: addUpdateCategoryVC)
    
    viewController.addChildViewController(addUpdateCategoryVC)
    viewController.view.addSubview(addUpdateCategoryVC.view)
    
    let transform1 = CGAffineTransform(translationX: viewController.view.frame.width, y: 0)
    let transform2 = CGAffineTransform(translationX: -viewController.view.frame.width, y: 0)
    
    addUpdateCategoryVC.view.frame = viewController.view.frame
    addUpdateCategoryVC.view.transform = transform1
    UIView.animate(withDuration: 0.5, animations: {
      self.viewController.view.transform = transform2
    }, completion: { _ in
      addUpdateCategoryVC.view.transform = CGAffineTransform.identity
      self.viewController.view.transform = CGAffineTransform.identity
      addUpdateCategoryVC.didMove(toParentViewController: self.viewController)
    })
  }
  
}
