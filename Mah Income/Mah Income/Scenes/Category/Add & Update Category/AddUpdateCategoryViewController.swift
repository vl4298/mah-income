//
//  AddUpdateViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class AddUpdateCategoryViewController: UIViewController {
  
  @IBOutlet weak var categoryTextfield: UITextField!
  @IBOutlet weak var addupdateButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  
  var router: AddUpdateCategoryRouter!
  var isAimmingUpdate = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func cancelHandler(sender: UIButton) {
    router.transitionBackToListCategory()
  }
  
  @IBAction func addUpdateHandler(sender: UIButton) {
    
  }
  
}
