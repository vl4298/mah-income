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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    iconImageView.transform = CGAffineTransform.identity
    colorView.alpha = 0.0
  }
  
  func configure(menu: MenuItemModel) {
    iconImageView.image = UIImage(named: menu.img)
    nameLabel.text = menu.name
  }
  
  func animate(withCompletion completion: @escaping (CGRect) -> Void) {
    print(self.colorView.frame.origin)
    UIView.animate(withDuration: 0.5, animations: {
      self.colorView.alpha = 1.0
      self.iconImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }, completion: { _ in
      completion(self.colorView.frame)
    })
  }
  
}
