//
//  AddUpdateCategoryModelController.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class AddUpdateCategoryModelController {
  
  weak var viewController: AddUpdateCategoryViewController!
  
  fileprivate lazy var categoryWorker: CategoryWorker? = {
    return CategoryWorker()
  }()
  
  func addCategory(name: String) {
    guard let worker = categoryWorker else {
      viewController.presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    if let err = worker.insertCategory(name: name) {
      viewController.presentError(des: err.textMsg)
    } else {
      viewController.didAddNewCategory()
    }
  }
  
  func update(category: CategoryModel, updateName: String) {
    guard let worker = categoryWorker else {
      viewController.presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    if let err = worker.updateCategory(category: category, name: updateName) {
      viewController.presentError(des: err.textMsg)
    } else {
      viewController.didAddNewCategory()
    }
  }
  
}
