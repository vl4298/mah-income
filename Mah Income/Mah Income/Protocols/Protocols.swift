//
//  Protocols.swift
//  Mah Income
//
//  Created by Van Luu on 4/15/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

protocol MenuProtocol: class {
  
}

extension MenuProtocol where Self: UIViewController {
  func askContainerForPresentingNewScene(sceneIdentify: String, menuItemPlace: CGRect) {
    guard let parentVC = self.parent else {
      print("parent is nil")
      return
    }
    
    if parentVC is ContainerProtocol {
      (parentVC as! ContainerProtocol).presentNewSceneWith(identify: sceneIdentify, animationPlace: menuItemPlace)
    } else {
      print("not ContainerProtocol")
    }
  }
}

protocol MenuContainer: class {
  var menu: MenuProtocol! {get set}
  
  func presentMenu()
  func dismissMenu()
}

protocol MenuPresentable: class {
}

extension MenuPresentable where Self: UIViewController {
  func askContainerToPresentMenu() {
    guard let parentVC = self.parent else {
      print("parent is nil")
      return
    }
    
    if parentVC is MenuContainer {
      (parentVC as! MenuContainer).presentMenu()
    } else {
      print("not MenuContainer")
    }
  }
}

protocol ContainerProtocol: class {
  var currentVC: UIViewController! { get set}
  
  func presentNewSceneWith(identify: String, animationPlace: CGRect)
  func present(newController newVC: UIViewController, initialFrame: CGRect)
}









