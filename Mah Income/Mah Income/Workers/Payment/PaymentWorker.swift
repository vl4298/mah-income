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
  
  func deletePaymentWithSameCategory(objects: LinkingObjects<PaymentModel>) -> MahError? {
    return helper.deletePayment(objects: objects)
  }
  
  func deletePayment(payment: PaymentModel) -> MahError? {
    return helper.deletePayment(payment)
  }
  
  func getAllPayment() -> Results<PaymentModel> {
    return helper.getAllPayment()
  }
  
  func getAllPaymentWith(category: String, reason: String) -> Results<PaymentModel> {
    return helper.getPaymentWith(filter: "category._name = '\(category)' AND reason.title = '\(reason)'")
  }
  
  func getAllPaymentsFrom(date: Date) -> Results<PaymentModel> {
    let predicate = NSPredicate(format: "date >= %@", (date as NSDate))
    return helper.getPaymentWith(filter: predicate)
  }
  
  func getAllPaymentsWith(category: String, from date: Date) -> Results<PaymentModel> {
    let predicate = NSPredicate(format: "date >= %@ AND category._name = '\(category)'", (date as NSDate))
    return helper.getPaymentWith(filter: predicate)
  }

  
}
