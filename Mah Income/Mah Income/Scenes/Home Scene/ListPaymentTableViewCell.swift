//
//  ListPaymentTableViewCell.swift
//  Mah Income
//
//  Created by Van Luu on 4/22/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class ListPaymentTableViewCell: UITableViewCell {
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var subCategoryLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var containerView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.contentView.layer.shouldRasterize = false
    selectionStyle = .none
  }
  
  func configure(payment: PaymentModel) {
    dateLabel.text = ApplicationManager.dateFormatter.string(from: payment.date)
    categoryLabel.text = payment.category
    subCategoryLabel.text = payment.subCategory
    amountLabel.text = "$\(payment.amount)"
  }
  
  func didSelectCell() {
    UIView.animate(withDuration: 0.2, animations: {
      self.containerView.backgroundColor = AppColor.mainColor
    }, completion: { _ in
    
      UIView.animate(withDuration: 0.2) {
        self.containerView.backgroundColor = UIColor.white
      }
    })
  }
  
}
