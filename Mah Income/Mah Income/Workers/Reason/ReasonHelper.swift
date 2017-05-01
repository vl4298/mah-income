//
//  ReasonHelper.swift
//  Mah Income
//
//  Created by Van Luu on 4/30/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class ReasonHelper: RealmBaseHelper {
  
}

extension ReasonHelper {
  
  func insertReason(_ Reason: ReasonModel) -> MahError? {
    
    do {
      try self.insert(object: Reason)
      return nil
      
    } catch {
      return MahError.cannotInsert
    }
  }
  
//  func updateReason(_ category: ReasonModel, name: String) -> MahError? {
//    do {
//      try self.update {
//        
//      }
//      
//      return nil
//      
//    } catch {
//      return MahError.cannotUpdate
//    }
//  }
  
  func deleteReason(_ Reason: ReasonModel) -> MahError? {
    do {
      try self.delete(object: Reason)
      return nil
      
    } catch {
      return MahError.cannotDelete
    }
  }
  
//  func categoryNameIsExist(_ name: String) -> Bool {
//    let result = realm.objects(ReasonModel.self).filter("_name == '\(name)'")
//    
//    if result.count > 0 { return true }
//    
//    return false
//  }
  
  func getAllReason() -> Results<ReasonModel> {
    return realm.objects(ReasonModel.self)
  }

  
}
