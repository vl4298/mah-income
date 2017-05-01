//
//  CategoryModel.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryModel: Object {
  dynamic var _name = ""
  
  let owners = LinkingObjects(fromType: PaymentModel.self, property: "category")
}
