//
//  ReasonTableViewCell.swift
//  Mah Income
//
//  Created by Van Luu on 4/16/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class ReasonTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var reasonStackView: UIStackView!
  @IBOutlet weak var underlineButton: MM3DButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()

    self.selectionStyle = .none
    reasonStackView.isUserInteractionEnabled = false
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    commentLabel.isHidden = false
  }
  
  func configureData(model: ReasonViewModel) {
    titleLabel.text = model.title
    
    if let comment = model.comment {
      commentLabel.text = comment
    } else {
      commentLabel.isHidden = true
    }
  }
  
}
