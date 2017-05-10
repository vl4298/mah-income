//
//  AnalyzeRouter.swift
//  Mah Income
//
//  Created by Van Luu on 5/8/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

class AnalyzeRouter {
  
  weak var viewController: AnalyzeViewController!
  var tempView: UIButton!
  
  fileprivate var vc: AnalyzeOptionViewController!
  
  func addAnalyzeOptionScene() {
    vc = viewController.storyboard!.instantiateViewController(type: AnalyzeOptionViewController.self)!
    let analyzeOptionSize = CGSize(width: viewController.view.bounds.width, height: 250.0)
    vc.vcDelegate = viewController
    
    viewController.addChildViewController(vc)
    vc.view.frame = CGRect(x: 0, y: viewController.view.bounds.height - analyzeOptionSize.height - 20, width: analyzeOptionSize.width, height: analyzeOptionSize.height)
    vc.view.transform = CGAffineTransform(translationX: 0, y: analyzeOptionSize.height)
    
    tempView = UIButton()
    tempView.frame = viewController.view.bounds
    tempView.backgroundColor = UIColor.black
    tempView.alpha = 0.0
    tempView.addTarget(vc, action: #selector(vc.removeWithQuery), for: .touchUpInside)
    
    viewController.view.addSubview(tempView)
    viewController.view.addSubview(vc.view)
    
    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
      self.vc.view.transform = CGAffineTransform.identity
      self.viewController.optionButton.alpha = 0.0
      self.tempView.alpha = 0.6
    }, completion: { _ in
      self.vc.didMove(toParentViewController: self.viewController)
    })

  }
  
  func dismissAnalyzeOptionScene() {
    vc.willMove(toParentViewController: nil)
    
    UIView.animate(withDuration: 0.3, animations: {
      self.vc.view.transform = CGAffineTransform(translationX: 0, y: self.vc.view.bounds.height)
      self.tempView.alpha = 0.0
      self.viewController.optionButton.alpha = 1.0
    }, completion: { _ in
      self.vc.view.removeFromSuperview()
      self.vc.removeFromParentViewController()
      self.tempView.removeFromSuperview()
      self.viewController.view.bringSubview(toFront: self.viewController.optionButton)
    })
  }
  
  func presentAnalyzeDetailScene(payments: Results<PaymentModel>, summaryInfo: (title: String, number: Double)) {
    let analyzeDetailVC = viewController.storyboard!.instantiateViewController(type: AnalyzeDetailViewController.self)!
    analyzeDetailVC.payments = payments
    analyzeDetailVC.summaryInfo = summaryInfo
    
    viewController.present(analyzeDetailVC, animated: true, completion: nil)
  }
  
}
