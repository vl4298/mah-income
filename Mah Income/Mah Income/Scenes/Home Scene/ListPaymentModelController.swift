//
//  ListPaymentModelController.swift
//  Mah Income
//
//  Created by Van Luu on 5/1/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class ListPaymentModelController {
  
  weak var viewController: ListPaymentViewController!
  
  fileprivate lazy var paymentWorker: PaymentWorker? = {
    return PaymentWorker()
  }()
  
  func fetchAllPayment() {
    guard let worker = paymentWorker else {
      viewController.presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    viewController.reloadData(listPayment: worker.getAllPayment())
  }
  
}
