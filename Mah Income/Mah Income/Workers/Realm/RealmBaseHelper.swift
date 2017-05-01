//
//  RealmBaseHelper.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class RealmBaseHelper {
  
  var realm: Realm!
  
  init() throws {
    realm = try Realm()
  }
  
  func insert(object: Object) throws {
    try realm.write {
      realm.add(object)
    }
  }
  
  func update(handler: (Void) -> Void) throws {
    try realm.write {
      handler()
    }
  }
  
  func delete(object: Object) throws {
    try realm.write {
      realm.delete(object)
    }
  }
  
}
