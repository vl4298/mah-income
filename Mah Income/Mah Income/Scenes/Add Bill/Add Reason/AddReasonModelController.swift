//
//  AddReasonModelController.swift
//  Mah Income
//
//  Created by Van Luu on 4/30/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class AddReasonModelController {
  
  weak var viewController: AddReasonViewController!
  
  fileprivate lazy var reasonWorker: ReasonWorker? = {
    return ReasonWorker()
  }()
  
  func addReason(title: String, comment: String?) {
    guard let worker = reasonWorker else {
      viewController.presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    if let err = worker.insertReason(title: title, comment: comment) {
      viewController.presentError(des: err.textMsg)
    } else {
      viewController.didAddNewReason()
    }
  }
  
//  func update(reason: ReasonModel, updateName: String) {
//    guard let worker = reasonWorker else {
//      viewController.presentError(des: MahError.cannotInit.textMsg)
//      return
//    }
//    
//    if let err = worker.updateCategory(category: category, name: updateName) {
//      viewController.presentError(des: err.textMsg)
//    } else {
//      viewController.didAddNewCategory()
//    }
//  }
  
}
