//
//  CategoryLayoutAttribute.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class CategoryLayoutAttribute: UICollectionViewLayoutAttributes {

  var scaleFactor: CGFloat = 1.0
  var alphaFactor: CGFloat = 1.0
  
  override func copy(with zone: NSZone? = nil) -> Any {
    if let attribute = super.copy(with: zone) as? CategoryLayoutAttribute {
      attribute.scaleFactor = scaleFactor
      attribute.alphaFactor = alphaFactor
      return attribute
    }
    
    return super.copy(with: zone)
  }
  
  override func isEqual(_ object: Any?) -> Bool {
    if let attribute = object as? CategoryLayoutAttribute {
      if attribute.scaleFactor == self.scaleFactor && attribute.alphaFactor == alphaFactor {
        return super.isEqual(object)
      }
    }
    
    return false
  }
  
}
