//
//  PaymentModel.swift
//  Mah Income
//
//  Created by Van Luu on 5/1/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation
import RealmSwift

class PaymentModel: Object {
  dynamic var category: CategoryModel?
  dynamic var reason: ReasonModel?
  dynamic var value: Double = 0.0
  dynamic var date = NSDate()
}
