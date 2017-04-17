//
//  ReasonViewModel.swift
//  Mah Income
//
//  Created by Van Luu on 4/16/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation

struct ReasonViewModel {
  
  var title: String
  var comment: String?
  
  init(title: String, comment: String) {
    self.title = title
    self.comment = comment
  }
  
  init(title: String) {
    self.init(title: title, comment: "")
  }
  
}
