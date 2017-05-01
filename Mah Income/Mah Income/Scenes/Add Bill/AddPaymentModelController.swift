//
//  AddPaymentModelController.swift
//  Mah Income
//
//  Created by Van Luu on 4/30/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

class AddPaymentModelController {
  
  weak var viewController: AddPaymentViewController!
  
  fileprivate lazy var paymentWorker: PaymentWorker? = {
    return PaymentWorker()
  }()
  
  fileprivate lazy var categoryWorker: CategoryWorker? = {
    return CategoryWorker()
  }()
  
  fileprivate var payment: PaymentModel = PaymentModel()
  
  func fetchAllCategory() {
    guard let worker = categoryWorker else {
      viewController.presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    viewController.reloadData(listCategories: worker.getAllCategory())
  }
  
  func set(category: CategoryModel) {
    payment.category = category
  }
  
  func set(reason: ReasonModel) {
    payment.reason = reason
  }
  
  func set(value: Double) {
    payment.value = value
  }
  
  func insertNewPayment() {
    
    if payment.value <= 0 {
      viewController.presentError(des: MahError.cannotInsert.textMsg)
    }
    
    guard let worker = paymentWorker else {
      viewController.presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    if let err = worker.insertPayment(payment: self.payment) {
      viewController.presentError(des: err.textMsg)
    } else {
      viewController.didAddNewPayment()
    }
  }
  
}
