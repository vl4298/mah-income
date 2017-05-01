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
  
  lazy var menuButton: UIButton = {
    let button = UIButton()
    button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    button.layer.cornerRadius = button.frame.width/2
    button.backgroundColor = AppColor.menuButton
    button.layer.shadowColor = AppColor.menuButtonShadow.cgColor
    button.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
    button.layer.shadowOpacity = 1.0
    
    button.addTarget(self, action: #selector(self.presentMenu), for: .touchUpInside)
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let homeVC = storyboard!.instantiateViewController(type: ListPaymentViewController.self) {
      ListPaymentConfigurator.sharedInstance.configure(viewController: homeVC)
      addChildViewController(homeVC)
      homeVC.view.frame = view.frame
      view.addSubview(homeVC.view)
      homeVC.didMove(toParentViewController: self)
      
      currentVC = homeVC
    } else {
      print("can not instante")
    }
    
    view.addSubview(menuButton)
    view.bringSubview(toFront: menuButton)
    menu = storyboard!.instantiateViewController(type: MenuViewController.self)!
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    menuButton.frame.origin = CGPoint(x: -menuButton.frame.width/2, y: view.frame.height/2 - menuButton.frame.height/2)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  func setupAfterPresentNewScene() {
    currentVC.willMove(toParentViewController: nil)
    currentVC.view.removeFromSuperview()
    currentVC.removeFromParentViewController()
    
    dismissMenu()
  }
  
  func animateMenuButtonIn() {
    view.bringSubview(toFront: menuButton)
    menuButton.frame.origin = CGPoint(x: -menuButton.frame.width, y: view.frame.height/2 - menuButton.frame.height/2)
    UIView.animate(withDuration: 0.3) {
      self.menuButton.frame.origin = CGPoint(x: -self.menuButton.frame.width/2, y: self.view.frame.height/2 - self.menuButton.frame.height/2)
    }
  }
  
}

extension ContainerViewController: MenuContainer {
  func presentMenu() {
    let isVC = menu is UIViewController
    if isVC {
      menuButton.isHidden = true
      
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
    let _menu = menu as! MenuViewController
    _menu.willMove(toParentViewController: nil)
    _menu.view.removeFromSuperview()
    _menu.removeFromParentViewController()
    
    _menu.tableView.reloadData()
    menuButton.isHidden = false
    animateMenuButtonIn()
  }
}

extension ContainerViewController: ContainerProtocol {
  func presentNewSceneWith(identify: String, animationPlace: CGRect) {
    var vc: UIViewController!
    switch identify {
    case "ListPaymentViewController":
      vc = self.storyboard!.instantiateViewController(type: ListPaymentViewController.self)!
      ListPaymentConfigurator.sharedInstance.configure(viewController: vc as! ListPaymentViewController)
    case "AddPaymentViewController":
      vc = self.storyboard!.instantiateViewController(type: AddPaymentViewController.self)!
      AddPaymentConfigurator.sharedInstance.configure(viewController: vc as! AddPaymentViewController)
    case "CategoryViewController":
      vc = self.storyboard!.instantiateViewController(type: CategoryViewController.self)!
      CategoryConfigurator.sharedInstance.configure(viewController: vc as! CategoryViewController)
    case "AnalyzeViewController":
      vc = self.storyboard!.instantiateViewController(type: AnalyzeViewController.self)!
    case "SettingViewController":
      vc = self.storyboard!.instantiateViewController(type: SettingViewController.self)!
      
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
    maskLayerAnimation.duration = 0.6
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
