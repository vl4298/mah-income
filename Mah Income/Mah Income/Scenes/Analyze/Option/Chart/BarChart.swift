//
//  BarChart.swift
//  Mah Income
//
//  Created by Van Luu on 5/9/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit
import Charts

class BarChart: UIScrollView {
  fileprivate var barChartView: BarChartView!
  
  var data: [String: Double]! {
    didSet {
      setupDataAndAnimate()
    }
  }
  
  override var contentSize: CGSize {
    didSet {
      barChartView.frame.size = contentSize
    }
  }
  
  var animateDuration: TimeInterval = 1.4
  weak var vcdelegate: ChartDelegate!
  var kind: String = ""
  var extraData: String = ""
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupbarChartView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupbarChartView() {
    
    barChartView = BarChartView(frame: self.bounds)
    barChartView.drawGridBackgroundEnabled = false
    barChartView.highlightPerDragEnabled = false
    
    let leftAxis = barChartView.leftAxis
    leftAxis.enabled = false
    
    let rightAxis = barChartView.rightAxis
    rightAxis.enabled = false
    
    self.addSubview(barChartView)
    
    barChartView.chartDescription?.text = ""
    
    let legend = barChartView.legend
    legend.form = .circle
    legend.horizontalAlignment = .left
    legend.verticalAlignment = .bottom
    legend.orientation = .horizontal
    legend.formSize = 10.0
    legend.xEntrySpace = 100.0
    legend.yEntrySpace = 10.0
    legend.font = UIFont(name: "Avenir Next", size: 13.0)!
    
    barChartView.delegate = self
  }
  
  func setupDataAndAnimate() {
    var i: Double = 0
    var dataSets: [BarChartDataSet] = []
    for (field, value) in data {
      let entry = BarChartDataEntry(x: i, y: value)
      entry.data = [field: value] as AnyObject
      let dataSet = BarChartDataSet(values: [entry], label: field)
      dataSet.colors = [.random()]
      dataSets.append(dataSet)
      i += 1
    }
    
    let chartData = BarChartData(dataSets: dataSets)
    barChartView.data = chartData
    barChartView.animate(xAxisDuration: animateDuration, yAxisDuration: animateDuration, easingOption: .easeInCubic)
  }

}

extension BarChart: ChartViewDelegate {
  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    vcdelegate.barChartSelected(barChart: self, value: entry)
  }
}
