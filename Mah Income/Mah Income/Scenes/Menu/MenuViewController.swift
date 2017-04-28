//
//  MenuViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/18/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class MenuItemModel {
  var controllerIdentify: String
  var img: String
  var name: String
  var color: UIColor
  var isSelected = false
  
  init(controllerIdentify: String, img: String, name: String, color: UIColor, isSelected: Bool = false) {
    self.controllerIdentify = controllerIdentify
    self.img = img
    self.name = name
    self.color = color
    self.isSelected = isSelected
  }
}

fileprivate let menuData = [
  MenuItemModel(controllerIdentify: "ListPaymentViewController", img: "home", name: "Home", color: AppColor.Menu.home, isSelected: true),
  MenuItemModel(controllerIdentify: "AddPaymentViewController", img: "plus", name: "Add Bill", color: AppColor.Menu.addBill),
  MenuItemModel(controllerIdentify: "CategoryViewController", img: "category", name: "Category", color: AppColor.Menu.category),
  MenuItemModel(controllerIdentify: "AnalyzeViewController", img: "analyze", name: "Analyze", color: AppColor.Menu.analyze),
  MenuItemModel(controllerIdentify: "SettingViewController", img: "setting", name: "Setting", color: AppColor.Menu.setting),
]

class MenuViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var selectedMenu: MenuItemModel? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    selectedMenu = menuData.first!
  }
  
}

extension MenuViewController: MenuProtocol {
  
}

extension MenuViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
    
    let menuItem = menuData[indexPath.row]
    cell.configure(menu: menuItem)
    
    return cell
  }
  
}

extension MenuViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let menuItem = menuData[indexPath.row]
    
    if menuItem.isSelected {
      return
    }
    
    selectedMenu?.isSelected = false
    menuItem.isSelected = true
    selectedMenu = menuItem
    
    let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
    cell.animate {[weak self] colorViewFrame in
      guard let this = self else { return }
      
      let colorViewOriginInParent = cell.convert(colorViewFrame.origin, to: this.view)

      this.askContainerForPresentingNewScene(sceneIdentify: menuItem.controllerIdentify, menuItemPlace: CGRect(origin: colorViewOriginInParent, size: colorViewFrame.size))
    }
  }
}









