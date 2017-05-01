//
//  HomeViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/15/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

class ListPaymentViewController: UIViewController, NotificationPresentable {
  
  @IBOutlet weak var tableView: UITableView!
  
  var payments: Results<PaymentModel>?
  var modelController: ListPaymentModelController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 150.0
    
    modelController.fetchAllPayment()
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
}

extension ListPaymentViewController: MenuPresentable {
}

extension ListPaymentViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return payments?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListPaymentTableViewCell") as! ListPaymentTableViewCell
    
    let payment = payments![indexPath.row]
    cell.configure(payment: payment)
    
    return cell
  }
  
}

extension ListPaymentViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! ListPaymentTableViewCell
    cell.didSelectCell()
  }
  
}

extension ListPaymentViewController {
  
  func reloadData(listPayment: Results<PaymentModel>) {
    payments = listPayment
    self.tableView.reloadData()
  }
}
