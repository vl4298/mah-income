//
//  CategoryWorker.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryWorker {
  
  var helper: CategoryHelper!
  
  init?() {
    do {
      try helper = CategoryHelper()
    } catch {
      return nil
    }
  }
  
  func insertCategory(name: String) -> MahError? {
    // TODO: add extension to filter name
    let finalName = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    
    if finalName == "" {
      return MahError.cannotInsert
    }
    
    if helper.categoryNameIsExist(finalName) {
      return MahError.isExist
    }
    
    let category = CategoryModel()
    category._name = name
    
    return helper.insertCategory(category)
  }
  
  func updateCategory(category: CategoryModel, name: String) -> MahError? {
    // TODO: filter Name
    let finalName = name
    
    return helper.updateCategory(category, name: finalName)
  }
  
  func deleteCategory(category: CategoryModel) -> MahError? {
    return helper.deleteCategory(category)
  }
  
  func getAllCategory() -> Results<CategoryModel> {
    return helper.getAllCategory()
  }
}
