//
//  AddReasonViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class AddReasonViewController: UIViewController {
  
  var router: AddReasonRouter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func handlerCancel(sender: UIButton) {
    router.transitionBackToListReason()
  }
  
}
