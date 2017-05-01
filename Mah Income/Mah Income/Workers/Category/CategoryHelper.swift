//
//  CategoryHelper.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryHelper: RealmBaseHelper {
  
}

extension CategoryHelper: CategoryHelperProtocol {
  
  func insertCategory(_ category: CategoryModel) -> MahError? {
    
    do {
      try self.insert(object: category)
      return nil
      
    } catch {
      return MahError.cannotInsert
    }
  }
  
  func updateCategory(_ category: CategoryModel, name: String) -> MahError? {
    do {
      try self.update {
        category._name = name
      }
      
      return nil
      
    } catch {
      return MahError.cannotUpdate
    }
  }
  
  func deleteCategory(_ category: CategoryModel) -> MahError? {
    do {
      try self.delete(object: category)
      return nil
      
    } catch {
      return MahError.cannotDelete
    }
  }
  
  func categoryNameIsExist(_ name: String) -> Bool {
    let result = realm.objects(CategoryModel.self).filter("_name == '\(name)'")
    
    if result.count > 0 { return true }
    
    return false
  }
  
  func getAllCategory() -> Results<CategoryModel> {
    return realm.objects(CategoryModel.self)
  }
}
