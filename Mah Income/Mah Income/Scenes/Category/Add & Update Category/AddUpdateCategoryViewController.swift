//
//  AddUpdateViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/28/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

protocol AddUpdateCategoryViewControllerDelegate: class {
  func didAddNewCategory(viewController: AddUpdateCategoryViewController)
  func didUpdateNewCategory(viewController: AddUpdateCategoryViewController)
}

class AddUpdateCategoryViewController: UIViewController {
  
  @IBOutlet weak var categoryTextfield: UITextField!
  @IBOutlet weak var addupdateButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  
  var router: AddUpdateCategoryRouter!
  var modelController: AddUpdateCategoryModelController!
  weak var delegate: AddUpdateCategoryViewControllerDelegate!
  var isAimmingUpdate = false
  var updateCategory: CategoryModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if isAimmingUpdate {
      addupdateButton.setTitle("update", for: .normal)
      categoryTextfield.text = updateCategory!._name
    } else {
      addupdateButton.setTitle("add", for: .normal)
    }

  }
  
  @IBAction func cancelHandler(sender: UIButton) {
    router.transitionBackToListCategory()
  }
  
  @IBAction func addUpdateHandler(sender: UIButton) {
    if isAimmingUpdate {
      modelController.update(category: updateCategory!, updateName: categoryTextfield.text!)
    } else {
      modelController.addCategory(name: categoryTextfield.text!)
    }
  }
  
}

extension AddUpdateCategoryViewController {
  
  func presentError(des: String) {
    print(des)
  }
  
  func didAddNewCategory() {
    delegate.didAddNewCategory(viewController: self)
    router.transitionBackToListCategory()
  }
  
}
