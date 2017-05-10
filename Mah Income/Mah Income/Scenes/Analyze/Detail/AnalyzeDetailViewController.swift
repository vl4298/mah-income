//
//  AnalyzeDetailViewController.swift
//  Mah Income
//
//  Created by Van Luu on 5/9/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

class AnalyzeDetailViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var payments: Results<PaymentModel>?
  var summaryInfo: (title: String, number: Double)!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 150.0
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  @IBAction func handleBackButton(sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

extension AnalyzeDetailViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return payments?.count == nil ? 0 : (payments!.count + 1)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "NumberOfTimesCell")!
      
      if let numberLabel = cell.viewWithTag(10) as? UILabel {
        numberLabel.text = "\(summaryInfo.number)"
      }
      
      if let titleLabel = cell.viewWithTag(20) as? UILabel {
        titleLabel.text = "\(summaryInfo.title)"
      }
      
      return cell
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListPaymentTableViewCell") as! ListPaymentTableViewCell
    
    let payment = payments![indexPath.row - 1]
    cell.configure(payment: payment)
    
    return cell
  }
  
}
