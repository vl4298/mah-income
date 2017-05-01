//
//  ReasonWorker.swift
//  Mah Income
//
//  Created by Van Luu on 4/30/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class ReasonWorker {
  var helper: ReasonHelper!
  
  init?() {
    do {
      try helper = ReasonHelper()
    } catch {
      return nil
    }
  }
  
  func insertReason(title: String, comment: String? = nil) -> MahError? {
    // TODO: add extension to filter name
    let finalName = title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    
    if finalName == "" {
      return MahError.cannotInsert
    }
    
    let reason = ReasonModel()
    reason.title = title
    reason.comment = comment
    
    return helper.insertReason(reason)
  }
  
//  func updateReason(reason: Reason, name: String) -> MahError? {
//    // TODO: filter Name
//    let finalName = name
//    
//    return helper.updateCategory(category, name: finalName)
//  }
  
//  func deleteCategory(category: CategoryModel) -> MahError? {
//    return helper.deleteCategory(category)
//  }
  
  func getAllReason() -> Results<ReasonModel> {
    return helper.getAllReason()
  }

}
