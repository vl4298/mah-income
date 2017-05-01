//
//  AddReasonViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

protocol AddReasonViewControllerDelegate: class {
  func didAddNewReason(viewController: AddReasonViewController)
}

class AddReasonViewController: UIViewController, NotificationPresentable {
  
  @IBOutlet weak var titleTextfield: UITextField!
  @IBOutlet weak var commentTextView: UITextView!
  
  var router: AddReasonRouter!
  var modelController: AddReasonModelController!
  weak var delegate: AddReasonViewControllerDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func handlerCancel(sender: UIButton) {
    router.transitionBackToListReason()
  }
  
  @IBAction func handleAdd(sender: UIButton) {
    let title = titleTextfield.text!
    let comment = commentTextView.text == "" ? nil : commentTextView.text
    
    modelController.addReason(title: title, comment: comment)
  }
  
}

extension AddReasonViewController {
  
  func didAddNewReason() {
    delegate.didAddNewReason(viewController: self)
    router.transitionBackToListReason()
  }
  
}
