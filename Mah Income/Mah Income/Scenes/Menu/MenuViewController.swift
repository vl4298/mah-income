//
//  MenuViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/18/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

struct MenuItemModel {
  var controllerIdentify: String
  var img: String
  var name: String
  
  init(controllerIdentify: String = "HomeViewController", img: String, name: String) {
    self.controllerIdentify = controllerIdentify
    self.img = img
    self.name = name
  }
}

fileprivate let menuData = [

  MenuItemModel(controllerIdentify: "AnalyzeViewController", img: "analyze", name: "Analyze"),
  MenuItemModel(img: "analyze", name: "Analyze"),
  MenuItemModel(controllerIdentify: "AnalyzeViewController", img: "analyze", name: "Analyze"),
  MenuItemModel(img: "analyze", name: "Analyze"),
  MenuItemModel(controllerIdentify: "AnalyzeViewController", img: "analyze", name: "Analyze"),
  MenuItemModel(img: "analyze", name: "Analyze"),
]

class MenuViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
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
    let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
    cell.animate {[weak self] colorViewFrame in
      guard let this = self else { return }
      
      let colorViewOriginInParent = cell.convert(colorViewFrame.origin, to: this.view)

      this.askContainerForPresentingNewScene(sceneIdentify: menuItem.controllerIdentify, menuItemPlace: CGRect(origin: colorViewOriginInParent, size: colorViewFrame.size))
    }
  }
}









