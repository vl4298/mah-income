//
//  PaymentWorker.swift
//  Mah Income
//
//  Created by Van Luu on 5/1/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class PaymentWorker {
  
  var helper: PaymentHelper!
  
  init?() {
    do {
      try helper = PaymentHelper()
    } catch {
      return nil
    }
  }
  
  func insertPayment(payment: PaymentModel) -> MahError? {
    
    return helper.insertPayment(payment)
  }
  
//  func updateCategory(category: CategoryModel, name: String) -> MahError? {
//    // TODO: filter Name
//    let finalName = name
//    
//    return helper.updateCategory(category, name: finalName)
//  }
  
  func deletePaymentWithSameCategory(objects: LinkingObjects<PaymentModel>) -> MahError? {
    return helper.deletePayment(objects: objects)
  }
  
  func deletePayment(payment: PaymentModel) -> MahError? {
    return helper.deletePayment(payment)
  }
  
  func getAllPayment() -> Results<PaymentModel> {
    return helper.getAllPayment()
  }

  
}
