//
//  ApplicationManager.swift
//  Mah Income
//
//  Created by Van Luu on 4/22/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import Foundation

class ApplicationManager {
  
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    
    return formatter
  }()
  
}
