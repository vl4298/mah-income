//
//  ContainerViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/15/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, MenuContainer {
  
  var menu: MenuProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let homeVC = storyboard!.instantiateViewController(type: HomeViewController.self) {
      addChildViewController(homeVC)
      homeVC.view.frame = view.frame
      view.addSubview(homeVC.view)
      homeVC.didMove(toParentViewController: self)
    } else {
      print("can not instante")
    }
    
    menu = storyboard!.instantiateViewController(type: MenuViewController.self)!
    
  }
  
  func presentMenu() {
    let isVC = menu is UIViewController
    if isVC {
      let menuVC = menu as! UIViewController
      
      addChildViewController(menuVC)
      menuVC.view.frame = view.frame
      view.addSubview(menuVC.view)
      menuVC.didMove(toParentViewController: self)
    } else {
      print("menu is not a view controller")
    }
    
  }
  
  func dismissMenu() {
    
  }
  
}
