//
//  PaymentHelper.swift
//  Mah Income
//
//  Created by Van Luu on 5/1/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class PaymentHelper: RealmBaseHelper {
  
}

extension PaymentHelper {
  
  
  func insertPayment(_ payment: PaymentModel) -> MahError? {
    
    do {
      try self.insert(object: payment)
      return nil
      
    } catch {
      return MahError.cannotInsert
    }
  }
  
//  func updatePayment(_ payment: CategoryModel, name: String) -> MahError? {
//    do {
//      try self.update {
//        category._name = name
//      }
//      
//      return nil
//      
//    } catch {
//      return MahError.cannotUpdate
//    }
//  }
  
  func deletePayment(objects: LinkingObjects<PaymentModel>) -> MahError? {
    do {
      try realm.write {
        for obj in objects {
          realm.delete(obj)
        }
      }
      return nil
    } catch {
      return MahError.cannotDelete
    }
  }
  
  func deletePayment(_ payment: PaymentModel) -> MahError? {
    do {
      try self.delete(object: payment)
      return nil
      
    } catch {
      return MahError.cannotDelete
    }
  }
  
//  func categoryNameIsExist(_ name: String) -> Bool {
//    let result = realm.objects(CategoryModel.self).filter("_name == '\(name)'")
//    
//    if result.count > 0 { return true }
//    
//    return false
//  }
  
  func getAllPayment() -> Results<PaymentModel> {
    return realm.objects(PaymentModel.self).sorted(byKeyPath: "date", ascending: false)
  }
  
  func getPaymentWith(filter: String) -> Results<PaymentModel> {
    return realm.objects(PaymentModel.self).filter(filter).sorted(byKeyPath: "date", ascending: false)
  }
  
  func getPaymentWith(filter: NSPredicate) -> Results<PaymentModel> {
    return realm.objects(PaymentModel.self).filter(filter).sorted(byKeyPath: "date", ascending: false)
  }
  
  static func deleteAllPayment() {
    let realm = try! Realm()
    let result = realm.objects(PaymentModel.self)
    try! realm.write {
      realm.delete(result)
    }
    print("did delete")
  }
  
  
}
