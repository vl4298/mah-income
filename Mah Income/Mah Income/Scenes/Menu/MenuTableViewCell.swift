//
//  MenuTableViewCell.swift
//  Mah Income
//
//  Created by Van Luu on 4/20/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var colorView: UIView!
  
  var menu: MenuItemModel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  func configure(menu: MenuItemModel) {
    self.menu = menu
    iconImageView.image = UIImage(named: menu.img)
    nameLabel.text = menu.name
    nameLabel.textColor = menu.color
    
    if !menu.isSelected {
      iconImageView.alpha = 1.0
      colorView.transform = CGAffineTransform.identity
      colorView.backgroundColor = UIColor.white
    } else {
      iconImageView.alpha = 0.0
      colorView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
    }
  }
  
  func animate(withCompletion completion: @escaping (CGRect) -> Void) {
    UIView.animate(withDuration: 0.5, animations: {
      self.iconImageView.alpha = 0.0
      self.colorView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
      self.colorView.backgroundColor = self.menu.color
    }, completion: { _ in
      completion(self.colorView.frame)
    })
  }
  
}
