//
//  AnalyzeModelController.swift
//  Mah Income
//
//  Created by Van Luu on 5/9/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

class AnalyzeModelController {
  
  weak var viewController: AnalyzeViewController!
  
  fileprivate lazy var paymentWorker: PaymentWorker? = {
    return PaymentWorker()
  }()
  
  func fetchAllPaymentWith(category: String, reason: String) {
    
    guard let worker = paymentWorker else {
      viewController.presentError(des: "Can not init")
      return
    }
    
    let payments = worker.getAllPaymentWith(category: category, reason: reason)
    viewController.paymentsWith(category: category, reason: reason, payments: payments)
    
  }
  
  func fetchAllPaymentWith(category: String, from date: Date) {
    guard let worker = paymentWorker else {
      viewController.presentError(des: "Can not init")
      return
    }
    
    let payments = worker.getAllPaymentsWith(category: category, from: date)
    viewController.paymentsWith(category: category, from: date, payments: payments)
  }
  
}
