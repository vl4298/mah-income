//
//  AddPaymentViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class AddPaymentViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var router: AddPaymentRouter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let layout = CardBaseCollectionViewLayout() { attribute, factor in
      let att = (attribute as! CategoryLayoutAttribute)

      if let f = factor {
        att.scaleFactor = (1 - f*0.2)
        att.alphaFactor = (1 - f)
      }
    }
    layout.scrollDirection = .horizontal
    collectionView.collectionViewLayout = layout
    collectionView.dataSource = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupCollectionViewLayout()
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
  
}

extension AddPaymentViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return TestData.CategoryReason.value.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
    
    let model = TestData.CategoryReason.value[indexPath.item]
    cell.configure(model: model)
    
    return cell
  }
}

extension AddPaymentViewController: ListReasonViewProtocol {
  func listReason(controller: ListReasonViewController, didSelectReason reason: ReasonViewModel) {
    print("receive a reason:\(reason)")
  }
}















