//
//  Protocols.swift
//  Mah Income
//
//  Created by Van Luu on 4/15/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import PopupDialog

// MARK: --------------------ERROR------------------------
enum MahError {
  case cannotInsert
  case cannotUpdate
  case cannotDelete
  case isExist
  case cannotInit
  
  var textMsg: String {
    switch self {
    case .cannotInsert:
      return "There are some problem while inseting. Please try again! :)"
    case .cannotUpdate:
      return "There are some problem while updating. Please try again! :)"
    case .cannotDelete:
      return "There are some problem while deleting. Please try again! :)"
    case .isExist:
      return "Already Exist"
    default:
      return "Try again!!"
    }
  }
}

// MARK: --------------------MENU--------------------------

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

protocol NotificationPresentable {
}

extension NotificationPresentable where Self: UIViewController {
  
  func presentError(des: String) {
    let popup = PopupDialog(title: "Oops!!", message: des)
    
    let okbutton = CancelButton(title: "OK") {
      self.dismiss(animated: true, completion: nil)
    }
    
    popup.addButton(okbutton)
    
    self.present(popup, animated: true, completion: nil)
  }
  
  func presentSuccess(des: String) {
    let popup = PopupDialog(title: "Success!!", message: des)
    
    let okbutton = CancelButton(title: "OK") {
      self.dismiss(animated: true, completion: nil)
    }
    
    popup.addButton(okbutton)
    
    self.present(popup, animated: true, completion: nil)
  }
  
  func presentQuestionSheet(des: String, action1: @escaping (Void) -> Void, action1Title: String) {
    let popup = PopupDialog(title: "Hold on!!", message: des)
    
    let action1Button = DestructiveButton(title: action1Title) {
      action1()
    }
    
    let action2Button = CancelButton(title: "Cancel") {
      self.dismiss(animated: true, completion: nil)
    }
    
    popup.addButton(action1Button)
    popup.addButton(action2Button)
    
    self.present(popup, animated: true, completion: nil)
  }
}

// MARK: --------------------MODEL--------------------------

protocol CategoryModelProtocol {
  func name() -> String
  
  func set(name: String)
}

// MARK: --------------------HELPER--------------------------

protocol CategoryHelperProtocol {
  func insertCategory(_ category: CategoryModel) -> MahError?
  func updateCategory(_ category: CategoryModel, name: String) -> MahError?
  func deleteCategory(_ category: CategoryModel) -> MahError?
  
  func categoryNameIsExist(_ name: String) -> Bool
}









