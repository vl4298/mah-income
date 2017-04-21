//
//  AnalyzeViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/20/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class AnalyzeViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func presentMenu(sender: UIButton) {
    askContainerToPresentMenu()
  }
}

extension AnalyzeViewController: MenuPresentable {}
