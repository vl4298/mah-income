//
//  ListReasonModelController.swift
//  Mah Income
//
//  Created by Van Luu on 4/30/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class ListReasonModelController {
  
  weak var viewController: ListReasonViewController!
  
  fileprivate lazy var reasonWorker: ReasonWorker? = {
    return ReasonWorker()
  }()
  
  func fetchAllReason() {
    guard let worker = reasonWorker else {
      viewController.presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    viewController.reloadData(listReason: worker.getAllReason())
  }
  
}
