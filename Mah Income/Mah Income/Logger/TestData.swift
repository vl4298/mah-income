//
//  TestData.swift
//  Mah Income
//
//  Created by Van Luu on 4/13/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import Fakery

class TestData {
  
  fileprivate static let faker = Faker(locale: Locale.current.identifier)
  
  static func insertCategory(number: Int) {
    guard let categoryWorker = CategoryWorker() else {
      print("Can not init category")
      return
    }
    for _ in 0..<number {
      let name = faker.company.catchPhrase()
      let _ = categoryWorker.insertCategory(name: name)
    }
  }
  
  static func insertReason(number: Int) {
    guard let reasonWorker = ReasonWorker() else {
      print("Can not init reason")
      return
    }
    for i in 0..<number {
      let title = faker.commerce.productName()
      var comment: String? = nil
      if i % 2 == 0 {
        comment = faker.company.bs()
      }
      
      let _ = reasonWorker.insertReason(title: title, comment: comment)
    }
  }
  
  static func insertPayment(number: Int) {
    guard let categoryWorker = CategoryWorker() else {
      print("Can not init category")
      return
    }
    
    guard let reasonWorker = ReasonWorker() else {
      print("Can not init reason")
      return
    }
    
    guard let paymentWorker = PaymentWorker() else {
      print("Can not init payment")
      return
    }
    
    let listCategories = categoryWorker.getAllCategory()
    let listReasons = reasonWorker.getAllReason()
    
    for _ in 0..<number {
      
      let category = listCategories[Int(arc4random_uniform(UInt32(listCategories.count - 1)))]
      let reason = listReasons[Int(arc4random_uniform(UInt32(listReasons.count - 1)))]
      let value = arc4random_uniform(100) + 1
      let date = Date(timeIntervalSinceNow: TimeInterval(arc4random_uniform(259200*30)))
      
      let payment = PaymentModel()
      payment.category = category
      payment.reason = reason
      payment.value = Double(value)
      payment.date = date as NSDate
      
      let _ = paymentWorker.insertPayment(payment: payment)
    }
  }
  
}
