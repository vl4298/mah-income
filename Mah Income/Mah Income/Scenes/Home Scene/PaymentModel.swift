//
//  PaymentModel.swift
//  Mah Income
//
//  Created by Van Luu on 4/22/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation

struct PaymentModel {
  var id: Int
  var category: String
  var subCategory: String
  var comment: String
  var date: Date
  var amount: Float
  
  init() {
    id = 1
    category = "Food and Bus Ventra"
    subCategory = "Bale"
    comment = "Buy for friends"
    date = Date()
    amount = 12.25
  }
}
