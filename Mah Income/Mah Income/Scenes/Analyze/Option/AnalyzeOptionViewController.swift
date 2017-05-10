//
//  AnalyzeOptionViewController.swift
//  Mah Income
//
//  Created by Van Luu on 5/4/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

protocol AnalyzeOptionViewControllerDelegate: class {
  func dismiss(withQuery query: String)
  func pieChartWith(category: String, reasons: [String: Int], title: String)
  func barChartWith(payment: [String: Double], title: String, date: Date?)
}

class AnalyzeOptionViewController: UIPageViewController {
  
  var orderedViewControllers: [UIViewController] = []
  var model = OptionModelController()
  var currentIndex: Int = 0
  
  weak var vcDelegate: AnalyzeOptionViewControllerDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    delegate = self
    
    // Option One
    let optionOne = self.storyboard!.instantiateViewController(type: OptionOneViewController.self)!
    optionOne.delagate = self
    
    // Option Two
    let optionTwo = self.storyboard!.instantiateViewController(type: OptionTwoViewController.self)!
    optionTwo.delegate = self
    
    // append
    orderedViewControllers.append(optionOne)
    orderedViewControllers.append(optionTwo)
    
    if let firstViewController = orderedViewControllers.first {
      setViewControllers([firstViewController],
                         direction: .forward,
                         animated: true,
                         completion: nil)
    }
    
    for (index,item) in orderedViewControllers.enumerated() {
      item.view.tag = index
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  fileprivate func initVC<T: UIViewController>(vc: T.Type) -> T {
    return self.storyboard!.instantiateViewController(type: vc)!
  }
  
  
  func removeWithQuery() {
    let vc = orderedViewControllers[currentIndex]
    
    if vc is OptionProtocol {
      (vc as! OptionProtocol).getAnalyzeData()
    }
  }
  
}

extension AnalyzeOptionViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
      return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    
    guard previousIndex >= 0 else {
      return nil
    }
    
    guard orderedViewControllers.count > previousIndex else {
      return nil
    }
    
    return orderedViewControllers[previousIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
      return nil
    }
    
    let nextIndex = viewControllerIndex + 1
    let orderedViewControllersCount = orderedViewControllers.count
    
    guard orderedViewControllersCount != nextIndex else {
      return nil
    }
    
    guard orderedViewControllersCount > nextIndex else {
      return nil
    }
    
    return orderedViewControllers[nextIndex]
  }
  
}

extension AnalyzeOptionViewController: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    if completed {
      currentIndex = pageViewController.viewControllers!.first!.view.tag
    }
  }
}

extension AnalyzeOptionViewController: OptionOneViewControllerDelegate {
  func pieChartWith(category: String, data: [String : Int], title: String) {
    vcDelegate.pieChartWith(category: category, reasons: data, title: title)
  }
}

extension AnalyzeOptionViewController: OptionTwoViewControllerDelegate {
  func barChart(data: [String: Double], title: String, date: Date?) {
    vcDelegate.barChartWith(payment: data, title: title, date: date)
  }
}
