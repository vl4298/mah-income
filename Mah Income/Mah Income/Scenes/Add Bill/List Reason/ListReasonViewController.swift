//
//  ListReasonViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/16/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

protocol ListReasonViewProtocol: class {
  func listReason(controller: ListReasonViewController, didSelectReason reason: ReasonViewModel)
}

class ListReasonViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var router: ListReasonRouter!
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
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  func addReasonHandler() {
    router.addAddReasonScene()
  }
  
}

extension ListReasonViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return TestData.AddReason.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ReasonTableViewCell") as! ReasonTableViewCell
    
    let model = TestData.AddReason.value[indexPath.row]
    cell.configureData(model: model)
    
    return cell
  }
  
}

extension ListReasonViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("did select")
    delegate.listReason(controller: self, didSelectReason: TestData.AddReason.value[indexPath.row])
  }
}
