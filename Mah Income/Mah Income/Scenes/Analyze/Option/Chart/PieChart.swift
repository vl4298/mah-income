//
//  PieChartView.swift
//  Mah Income
//
//  Created by Van Luu on 5/9/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import Charts

class PieChart: UIScrollView {
  
  fileprivate var pieChartView: PieChartView!
  var data: [String: Int]! {
    didSet {
      setupDataAndAnimate()
    }
  }
  
  override var contentSize: CGSize {
    didSet {
      pieChartView.frame.size = contentSize
    }
  }
  
  var animateDuration: TimeInterval = 1.4
  weak var vcdelegate: ChartDelegate!
  var kind: String = ""
  var extraData: String = ""

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupPieChartView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupPieChartView() {
    
    pieChartView = PieChartView(frame: self.bounds)
    pieChartView.drawHoleEnabled = true
    pieChartView.rotationEnabled = false
    self.addSubview(pieChartView)
    
    pieChartView.drawEntryLabelsEnabled = false
    pieChartView.drawCenterTextEnabled = true
    pieChartView.chartDescription?.text = ""
    
    let legend = pieChartView.legend
    legend.form = .circle
    legend.horizontalAlignment = .left
    legend.verticalAlignment = .bottom
    legend.orientation = .horizontal
    legend.formSize = 10.0
    legend.xEntrySpace = 100.0
    legend.yEntrySpace = 10.0
    legend.font = UIFont(name: "Avenir Next", size: 13.0)!
    
    pieChartView.delegate = self
  }
  
  func setupDataAndAnimate() {
    var entries: [ChartDataEntry] = []
    for (field, value) in data {
      let entry = PieChartDataEntry(value: Double(value).rounded(), label: field)
      entry.data = [field: value] as AnyObject
      entries.append(entry)
    }
    
    let dataSet = PieChartDataSet(values: entries, label: "")
    
    for _ in 0..<data.count {
      dataSet.colors.append(.random())
    }
    
    dataSet.selectionShift = 0
    
    let chartData = PieChartData(dataSet: dataSet)
    pieChartView.data = chartData
    
    pieChartView.animate(xAxisDuration: animateDuration, easing: nil)
  }
}

extension PieChart: ChartViewDelegate {
  
  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    vcdelegate.pieChartSelected(pieChart: self, value: entry)
  }
  
}


