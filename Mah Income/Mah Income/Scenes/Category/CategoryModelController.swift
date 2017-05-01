//
//  CategoryModelController.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryModelController {
  
  weak var viewController: CategoryViewController!
  
  fileprivate lazy var categoryWorker: CategoryWorker? = {
    return CategoryWorker()
  }()
  
  fileprivate lazy var paymentWorker: PaymentWorker? = {
    return PaymentWorker()
  }()
  
  func fetchAllCategory() {
    guard let worker = categoryWorker else {
      viewController.presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    viewController.reloadData(listCategories: worker.getAllCategory())
  }
  
  func delete(category: CategoryModel) {
    guard let worker = categoryWorker else {
      viewController.presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    guard let pWorker = paymentWorker else {
      viewController.presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    if let err = pWorker.deletePaymentWithSameCategory(objects: category.owners) {
      viewController.presentError(des: err.textMsg)
    } else {
      if let err = worker.deleteCategory(category: category) {
        viewController.presentError(des: err.textMsg)
      } else {
        self.fetchAllCategory()
      }
      
    }
  }
}

