//
//  OptionTwoViewController.swift
//  Mah Income
//
//  Created by Van Luu on 5/8/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import RealmSwift

protocol OptionTwoViewControllerDelegate: class {
  func barChart(data: [String: Double], title: String, date: Date?)
}

class OptionTwoViewController: UIViewController {
  
  @IBOutlet weak var timeSliderbarWeeks: TimeSlidebarView!
  @IBOutlet weak var timeSliderbarMonths: TimeSlidebarView!
  @IBOutlet weak var timeSliderbarYears: TimeSlidebarView!
  
  var currentKind: TimeSlidebarView.Kind = .week
  var currentValue: Int = 1
  weak var delegate: OptionTwoViewControllerDelegate!
  
  lazy var modelController: OptionModelController = {
    
    let model = OptionModelController()
    model.viewController = self
    
    return model
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTimeSliderbar()
    
  }
  
  func setupTimeSliderbar() {
    timeSliderbarWeeks.kind = .week
    timeSliderbarMonths.kind = .month
    timeSliderbarYears.kind = .year
    
    timeSliderbarWeeks.delegate = self
    timeSliderbarMonths.delegate = self
    timeSliderbarYears.delegate = self
    
    timeSliderbarMonths.isEnable = false
    timeSliderbarYears.isEnable = false

  }
}

extension OptionTwoViewController: TimeSliderbarViewDelegate {
  func didStartChangingValue(timesSliderbar: TimeSlidebarView, newValue: Int, kind: TimeSlidebarView.Kind) {
    currentKind = kind
    currentValue = newValue
    
    if timesSliderbar.isEnable {
      return
    }

    timesSliderbar.isEnable = true
    
    switch kind {
    case .week:
      timeSliderbarMonths.isEnable = false
      timeSliderbarYears.isEnable = false
    case .month:
      timeSliderbarWeeks.isEnable = false
      timeSliderbarYears.isEnable = false
    case .year:
      timeSliderbarMonths.isEnable = false
      timeSliderbarWeeks.isEnable = false
    }
  }
}

extension OptionTwoViewController: AnalyzeOptionProtocol {
  func reloadData(listPayments: Results<PaymentModel>) {
    print(listPayments)
  }
  
  func reloadData(listCategories: Results<CategoryModel>) {
    // NONE
  }
}

extension OptionTwoViewController: OptionProtocol {
  func getAnalyzeData() {
    
    guard let date = modelController.dateFrom(kind: currentKind.component, value: -currentValue) else {
      print("can not init date")
      return
    }
    
    guard let payments = modelController.getPaymentsFrom(date: date) else {
      print("no payment")
      return
    }
    
    var results = [String : Double]()
    
    for payment in payments {
      
      if results[payment.category!._name] == nil {
        results[payment.category!._name] = payment.value
      } else {
        results[payment.category!._name]! += payment.value
      }
      
    }
    
    delegate.barChart(data: results, title: "Last \(currentValue) \(currentKind.text)", date: date)
    
  }
  
}

