//
//  HomeViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/15/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class ListPaymentViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 150.0
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  @IBAction func presentMenuHandler(sender: UIButton) {
    askContainerToPresentMenu()
  }
  
}

extension ListPaymentViewController: MenuPresentable {
}

extension ListPaymentViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return TestData.ListPayment.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListPaymentTableViewCell") as! ListPaymentTableViewCell
    
    let payment = TestData.ListPayment.value[indexPath.row]
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
