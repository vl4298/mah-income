//
//  AnalyzeViewController.swift
//  Mah Income
//
//  Created by Van Luu on 5/2/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class AnalyzeViewController: UIViewController, NotificationPresentable {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  lazy var optionButton: UIButton = {
    let button = UIButton()
    button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    button.layer.cornerRadius = button.frame.width/2
    button.backgroundColor = AppColor.menuButton
    button.layer.shadowColor = AppColor.menuButtonShadow.cgColor
    button.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
    button.layer.shadowOpacity = 1.0
    
    button.addTarget(self, action: #selector(self.presentOption), for: .touchUpInside)
    
    return button
  }()
  
  var router: AnalyzeRouter!
  var modelController: AnalyzeModelController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(optionButton)
    view.bringSubview(toFront: optionButton)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    optionButton.frame.origin = CGPoint(x: view.bounds.midX - optionButton.bounds.width/2, y: view.bounds.height - optionButton.bounds.height/2)
  }
  
  func presentOption() {
    router.addAnalyzeOptionScene()
  }
  
  func paymentsWith(category: String, reason: String, payments: Results<PaymentModel>) {
    let summaryInfo = (title: "Number of times", number: Double(payments.count))
    router.presentAnalyzeDetailScene(payments: payments, summaryInfo: summaryInfo)
  }
  
  func paymentsWith(category: String, from date: Date, payments: Results<PaymentModel>) {
    var sum: Double = 0
    for payment in payments {
      sum += payment.value
    }
    let summaryInfo = (title: "Sum", number: sum)
    router.presentAnalyzeDetailScene(payments: payments, summaryInfo: summaryInfo)
  }
  
}

extension AnalyzeViewController: AnalyzeOptionViewControllerDelegate {
  func dismiss(withQuery query: String) {
    router.dismissAnalyzeOptionScene()
  }
  
  
  func pieChartWith(category: String, reasons: [String: Int], title: String) {
    router.dismissAnalyzeOptionScene()
    titleLabel.text = title
    
    if let currentChart = view.viewWithTag(10) {
      currentChart.removeFromSuperview()
    }
    
    let pieChart = PieChart(frame: CGRect(x: 0, y: 50, width: view.bounds.width, height: view.bounds.height - 50 - 30))
    pieChart.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
    pieChart.tag = 10
    pieChart.kind = "category"
    pieChart.extraData = category
    pieChart.vcdelegate = self
    view.addSubview(pieChart)
    
    pieChart.data = reasons
  }
  
  func barChartWith(payment: [String: Double], title: String, date: Date?) {
    router.dismissAnalyzeOptionScene()
    titleLabel.text = title
    
    if let currentChart = view.viewWithTag(10) {
      currentChart.removeFromSuperview()
    }
    
    let barChart = BarChart(frame: CGRect(x: 0, y: 50, width: view.bounds.width, height: view.bounds.height - 50 - 30))
    barChart.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2.2)
    barChart.tag = 10
    barChart.vcdelegate = self
    view.addSubview(barChart)
    
    barChart.data = payment
    
    if let d = date {
      barChart.extraData = "\(d.timeIntervalSince1970)"
    }
    
  }
}

extension AnalyzeViewController: ChartDelegate {
  func pieChartSelected(pieChart: PieChart, value: ChartDataEntry) {
    if pieChart.kind == "category" {
      let category = pieChart.extraData
      var reason = ""
      
      for (key, _) in (value.data as! [String : Int]) {
        reason = key
      }
      
      modelController.fetchAllPaymentWith(category: category, reason: reason)
      
    } else {
      
      
      
    }
  }
  
  func barChartSelected(barChart: BarChart, value: ChartDataEntry) {
    guard let timeInterval = TimeInterval(barChart.extraData) else {
      print("not time interval")
      return
    }
    
    var category = ""
    for (key, _) in (value.data as! [String : Double]) {
      category = key
    }

    let date = Date(timeIntervalSince1970: timeInterval)
    modelController.fetchAllPaymentWith(category: category, from: date)
  }
}
