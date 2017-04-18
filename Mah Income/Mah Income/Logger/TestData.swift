//
//  TestData.swift
//  Mah Income
//
//  Created by Van Luu on 4/13/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation

struct TestData {
  
  struct AddReason {
    
    static let value = [
      ReasonViewModel(title: "Food: Bale"),
      ReasonViewModel(title: "Food: Tank", comment: "Only once, bad food, and annoying emplyee"),
      ReasonViewModel(title: "Food: Bale"),
      ReasonViewModel(title: "Food: Tank", comment: "Only once, bad food, and annoying emplyee"),
      ReasonViewModel(title: "Food: Mc Donald"),
      ReasonViewModel(title: "Food: Bale2")
    ]
  }
  
  struct CategoryReason {
    static let value = [
      CategoryReasonViewModel(name: "Food"),
      CategoryReasonViewModel(name: "Clothes"),
      CategoryReasonViewModel(name: "Ventra"),
      CategoryReasonViewModel(name: "Book + Tutorial")
    ]
  }
  
}
