//
//  OptionModelController.swift
//  Mah Income
//
//  Created by Van Luu on 5/8/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

class OptionModelController {
  
  weak var viewController: AnalyzeOptionProtocol!
  
  fileprivate lazy var categoryWorker: CategoryWorker? = {
    return CategoryWorker()
  }()
  
  fileprivate lazy var paymentWorker: PaymentWorker? = {
    return PaymentWorker()
  }()
  
  func fetchAllCategory() {
    guard let worker = categoryWorker else {
//      (viewController).presentError(des: MahError.cannotInit.textMsg)
      return
    }
    
    viewController.reloadData(listCategories: worker.getAllCategory())
  }
  
  func getPayment(of category: CategoryModel) -> LinkingObjects<PaymentModel> {
    return category.owners
  }
  
  func dateFrom(kind: Calendar.Component, value: Int) -> Date? {
    let calendar = Calendar.current
    return calendar.date(byAdding: kind, value: value, to: Date(), wrappingComponents: false)
  }
  
  func getPaymentsFrom(date: Date) -> Results<PaymentModel>? {
    guard let worker = paymentWorker else {
      //      (viewController).presentError(des: MahError.cannotInit.textMsg)
      return nil
    }
    
    return worker.getAllPaymentsFrom(date: date)
  }
  
  
}

