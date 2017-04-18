//
//  CategoryCollectionViewCell.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var categoryLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    categoryLabel.layer.cornerRadius = min(bounds.width, bounds.height)/2
    categoryLabel.layer.masksToBounds = true
  }
  
  func configure(model: CategoryReasonViewModel) {
    categoryLabel.text = model.name
  }
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    guard let attribute = layoutAttributes as? CategoryLayoutAttribute else { return }

    categoryLabel.alpha = attribute.alphaFactor
    categoryLabel.transform = CGAffineTransform(scaleX: attribute.scaleFactor, y: attribute.scaleFactor)
  }
}
