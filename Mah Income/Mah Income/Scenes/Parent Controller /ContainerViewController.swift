//
//  ContainerViewController.swift
//  Mah Income
//
//  Created by Van Luu on 4/15/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  
  var menu: MenuProtocol!
  var currentVC: UIViewController!
  var newVC: UIViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let homeVC = storyboard!.instantiateViewController(type: HomeViewController.self) {
      addChildViewController(homeVC)
      homeVC.view.frame = view.frame
      view.addSubview(homeVC.view)
      homeVC.didMove(toParentViewController: self)
    } else {
      print("can not instante")
    }
    
    menu = storyboard!.instantiateViewController(type: MenuViewController.self)!
    
  }
  
  func setupAfterPresentNewScene() {
    currentVC.willMove(toParentViewController: nil)
    currentVC.view.removeFromSuperview()
    currentVC.removeFromParentViewController()
    
    dismissMenu()
  }
  
}

extension ContainerViewController: MenuContainer {
  func presentMenu() {
    let isVC = menu is UIViewController
    if isVC {
      let menuVC = menu as! UIViewController
      
      addChildViewController(menuVC)
      menuVC.view.frame = view.frame
      menuVC.view.transform = CGAffineTransform(translationX: -menuVC.view.frame.width, y: 0)
      view.addSubview(menuVC.view)
      
      UIView.animate(withDuration: 0.3, animations: {
        menuVC.view.transform = CGAffineTransform.identity
      }, completion: { _ in
        menuVC.didMove(toParentViewController: self)
      })
    } else {
      print("menu is not a view controller")
    }
    
  }
  
  func dismissMenu() {
    let _menu = menu as! UIViewController
    _menu.willMove(toParentViewController: nil)
    _menu.view.removeFromSuperview()
    _menu.removeFromParentViewController()
  }
}

extension ContainerViewController: ContainerProtocol {
  func presentNewSceneWith(identify: String, animationPlace: CGRect) {
    var vc: UIViewController!
    switch identify {
    case "HomeViewController":
      vc = self.storyboard!.instantiateViewController(type: HomeViewController.self)!
    case "AnalyzeViewController":
      vc = self.storyboard!.instantiateViewController(type: AnalyzeViewController.self)!
      
    default:
      return
    }
    
    present(newController: vc, initialFrame: animationPlace)
  }
  
  func present(newController vc: UIViewController, initialFrame: CGRect) {
    addChildViewController(vc)
    vc.view.frame = currentVC.view.bounds
    view.addSubview(vc.view)
    vc.didMove(toParentViewController: self)
    newVC = vc
    
    let circleMaskPathInitial = UIBezierPath(ovalIn: initialFrame)
    let extremePoint = CGPoint(x: initialFrame.midX - 0, y: vc.view.frame.height/12 - vc.view.frame.height)
    let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
    let circleMaskPathFinal = UIBezierPath(ovalIn: initialFrame.insetBy(dx: -radius, dy: -radius))
    
    let maskLayer = CAShapeLayer()
    maskLayer.path = circleMaskPathFinal.cgPath
    vc.view.layer.mask = maskLayer
    
    let maskLayerAnimation = CABasicAnimation(keyPath: "path")
    maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
    maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
    maskLayerAnimation.duration = 1.0
    maskLayerAnimation.delegate = self
    maskLayer.add(maskLayerAnimation, forKey: "path")
  }
}

extension ContainerViewController: CAAnimationDelegate {
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    newVC!.view.layer.mask = nil
    
    setupAfterPresentNewScene()
    
    currentVC = newVC
    newVC = nil
  }
}
