//
//  AddPaymentViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

class AddPaymentViewController: UIViewController, NotificationPresentable {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var reasonLabel: UILabel!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var valueLabel: UILabel!
  
  var router: AddPaymentRouter!
  var categories: Results<CategoryModel>?
  var modelController: AddPaymentModelController!
  
  var layout: CardBaseCollectionViewLayout!
  var currentValue: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layout = CardBaseCollectionViewLayout() { attribute, factor in
      let att = (attribute as! CategoryLayoutAttribute)

      if let f = factor {
        att.scaleFactor = (1 - f*0.2)
        att.alphaFactor = (1 - f)
      }
    }
    layout.scrollDirection = .horizontal
    collectionView.collectionViewLayout = layout
    collectionView.dataSource = self
    
    modelController.fetchAllCategory()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupCollectionViewLayout()
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  func setupCollectionViewLayout() {
    let itemGap: CGFloat = 10.0
    let itemSize = CGSize(width: collectionView.bounds.size.width - 12*itemGap, height: collectionView.bounds.height)
    let inset = (collectionView.bounds.width - itemSize.width)/2
    
    let layout = collectionView.collectionViewLayout as! CardBaseCollectionViewLayout
    layout.minimumLineSpacing = itemGap
    layout.itemSize = itemSize
    collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
  }
  
  @IBAction func handlerReasonButton(sender: UIButton) {
    router.presentListReasonScene()
  }
  
  @IBAction func handleNumberButton(sender: UIButton) {
    if currentValue == "0" {
      currentValue = sender.titleLabel!.text!
    } else {
      currentValue = currentValue + sender.titleLabel!.text!
    }
    
    valueLabel.text = currentValue
  }
  
  @IBAction func handleDotButton(sender: UIButton) {
    if currentValue.contains(".") || currentValue == "0" { return }
    
    currentValue = currentValue + "."
    valueLabel.text = currentValue
  }
  
  @IBAction func handleBackspaceButton(sender: UIButton) {
    if currentValue == "" {
      return
    }
    
    currentValue = currentValue.substring(to: currentValue.index(before: currentValue.endIndex))
    
    if currentValue == "" {
      currentValue = "0"
    }
    
    valueLabel.text = currentValue
  }
  
  @IBAction func handleAddButton(sender: UIButton) {
    let value = Double(valueLabel.text!)
    
    guard let val = value, val > 0 else {
      presentError(des: "Bill must more than 0")
      return
    }
    
    modelController.set(value: val)
    
    guard let indexPath = collectionView.indexPathForItem(at: CGPoint(x: collectionView.contentOffset.x + collectionView.bounds.width/2, y: collectionView.bounds.height/2)) else {
      self.presentError(des: "Please create at least one category.")
      return
    }
    
    modelController.set(category: categories![indexPath.row])
    modelController.insertNewPayment()
    
  }
  
}

extension AddPaymentViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
    
    let model = categories![indexPath.row]
    cell.configure(model: model)
    
    return cell
  }
}

extension AddPaymentViewController: UIScrollViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
  }
}

extension AddPaymentViewController: ListReasonViewProtocol {
  func listReason(controller: ListReasonViewController, didSelectReason reason: ReasonModel) {
    modelController.set(reason: reason)
    router.dismissListReasonScene()
    let comment = reason.comment == nil ? "" : ":\(reason.comment!)"
    reasonLabel.text = "\(reason.title)\(comment)"
  }
}

extension AddPaymentViewController {
  
  func reloadData(listCategories: Results<CategoryModel>) {
    self.categories = listCategories
    self.collectionView.reloadData()
  }
  
  func didAddNewPayment() {
    self.presentSuccess(des: "You have added new bill =]]")
  }
}















