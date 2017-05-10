//
//  OptionOneViewController.swift
//  Mah Income
//
//  Created by Van Luu on 5/8/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

protocol OptionOneViewControllerDelegate: class {
  func pieChartWith(category: String, data: [String : Int], title: String)
}

class OptionOneViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  lazy var modelController: OptionModelController = {
    
    let model = OptionModelController()
    model.viewController = self
    
    return model
    
  }()
  
  var layout: CardBaseCollectionViewLayout!
  var categories: Results<CategoryModel>?
  weak var delagate: OptionOneViewControllerDelegate!
  
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
}

extension OptionOneViewController: UICollectionViewDataSource {
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

extension OptionOneViewController: AnalyzeOptionProtocol {
  func reloadData(listCategories: Results<CategoryModel>) {
    self.categories = listCategories
    self.collectionView.reloadData()
  }
  
  func reloadData(listPayments: Results<PaymentModel>) {
    // NONE
  }
}

extension OptionOneViewController: OptionProtocol {
  func getAnalyzeData() {
    
    guard let indexPath = collectionView.indexPathForItem(at: CGPoint(x: collectionView.contentOffset.x + collectionView.bounds.width/2, y: collectionView.bounds.height/2)) else {
      self.presentError(des: "Please create at least one category.")
      return
    }
    
    guard let _categories = categories else {
      print("can not categories")
      return
    }
    
    let category = _categories[indexPath.row]
    let payments = modelController.getPayment(of: category)
    
    var results = [String: Int]()
    for payment in payments {
      if let reason = payment.reason {
        
        if results[reason.title] == nil {
          results[reason.title] = 1
        } else {
          results[reason.title]! += 1
        }
        
      } else {
        
        if results["Other"] == nil {
          results["Other"] = 1
        } else {
          results["Other"]! += 1
        }
        
      }
      
    }
    
    delagate.pieChartWith(category: category._name, data: results, title: category._name)
  }
}
