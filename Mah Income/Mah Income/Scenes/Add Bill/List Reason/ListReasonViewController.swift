//
//  ListReasonViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/16/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

protocol ListReasonViewProtocol: class {
  func listReason(controller: ListReasonViewController, didSelectReason reason: ReasonModel)
}

class ListReasonViewController: UIViewController, NotificationPresentable {
  
  @IBOutlet weak var tableView: UITableView!
  
  var router: ListReasonRouter!
  var reasons: Results<ReasonModel>?
  var modelController: ListReasonModelController!
  weak var delegate: ListReasonViewProtocol!
  
  lazy var tableFooterView: UIView = {
    let footerView = UIView()
    footerView.frame.size = CGSize(width: self.view.bounds.width, height: 100.0)
    
    let addReasonButton = MM3DButton()
    footerView.addSubview(addReasonButton)
    
    addReasonButton.translatesAutoresizingMaskIntoConstraints = false
    addReasonButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
    addReasonButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
    addReasonButton.widthAnchor.constraint(equalTo: footerView.widthAnchor, constant: -20).isActive = true
    addReasonButton.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 0.5).isActive = true
    addReasonButton.backgroundColor = AppColor.AddReasonButton.backgroundColor
    addReasonButton.shadowColor = AppColor.AddReasonButton.shadowColor
    addReasonButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 25.0)
    addReasonButton.setTitle("add reason", for: .normal)
    addReasonButton.addTarget(self, action: #selector(self.addReasonHandler), for: .touchUpInside)
    
    return footerView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 150.0
    tableView.tableFooterView = tableFooterView
    
    modelController.fetchAllReason()
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  func addReasonHandler() {
    router.addAddReasonScene()
  }
  
  func handlerCellTap(sender: UIButton) {
    let buttonTag = sender.tag
    delegate.listReason(controller: self, didSelectReason: reasons![buttonTag])
  }
  
}

extension ListReasonViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reasons?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ReasonTableViewCell") as! ReasonTableViewCell
    
    let model = reasons![indexPath.row]
    cell.configureData(model: model)
    
    cell.underlineButton.addTarget(self, action: #selector(self.handlerCellTap(sender:)), for: .touchUpInside)
    cell.underlineButton.tag = indexPath.row
    
    return cell
  }
  
}

extension ListReasonViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate.listReason(controller: self, didSelectReason: reasons![indexPath.row])
  }
}

extension ListReasonViewController {
  
  func reloadData(listReason: Results<ReasonModel>) {
    reasons = listReason
    self.tableView.reloadData()
  }
  
}

extension ListReasonViewController: AddReasonViewControllerDelegate {
  func didAddNewReason(viewController: AddReasonViewController) {
    modelController.fetchAllReason()
  }
}



