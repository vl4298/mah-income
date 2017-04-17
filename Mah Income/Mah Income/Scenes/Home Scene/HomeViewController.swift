//
//  HomeViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/15/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var presentMenu: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func presentMenuHandler(sender: UIButton) {
    askContainerToPresentMenu()
  }
  
}

extension HomeViewController: MenuPresentable {
}
