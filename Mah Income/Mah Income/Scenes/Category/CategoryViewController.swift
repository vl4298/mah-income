//
//  CategoryViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/24/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var router: CategoryRouter!
  
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
    addReasonButton.addTarget(self, action: #selector(self.addCategoryHandler), for: .touchUpInside)
    
    return footerView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 100.0
    tableView.tableFooterView = tableFooterView
  }
  
  func addCategoryHandler() {
    router.addAddUpdateCategoryScene()
  }
  
}

extension CategoryViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return TestData.Category.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
    
    let category = TestData.Category.value[indexPath.row]
    cell.configure(category: category)
    
    return cell
  }
  
}

extension CategoryViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return false
  }
}
