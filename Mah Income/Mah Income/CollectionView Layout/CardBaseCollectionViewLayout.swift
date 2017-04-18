//
//  CardBaseCollectionViewLayout.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

typealias AttributeHandler = (UICollectionViewLayoutAttributes, CGFloat?) -> (Void)

class CardBaseCollectionViewLayout: UICollectionViewFlowLayout {

  fileprivate var handlerAttributeWithFactor: AttributeHandler!
  
  init(attributeHandler: @escaping AttributeHandler) {
    super.init()
    self.handlerAttributeWithFactor = attributeHandler
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override class var layoutAttributesClass: Swift.AnyClass {
    return CategoryLayoutAttribute.self
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = self.collectionView else { return CGPoint.zero }
    
    var offsetAdjust: CGFloat = 10000
    
    let horizontalCenter = proposedContentOffset.x + collectionView.bounds.width/2
    
    let proposedRect = CGRect(x: proposedContentOffset.x,
                              y: 0,
                              width: collectionView.bounds.width,
                              height: collectionView.bounds.height)
    
    guard let attributesArray = super.layoutAttributesForElements(in: proposedRect) else { return proposedContentOffset }
    
    for attribute in attributesArray {
      if case UICollectionElementCategory.supplementaryView = attribute.representedElementCategory { continue }
      
      let itemHorizontalCenter = attribute.center.x
      if fabs(itemHorizontalCenter - horizontalCenter) < fabs(offsetAdjust) {
        offsetAdjust = itemHorizontalCenter - horizontalCenter
      }
    }
    
    return CGPoint(x: proposedContentOffset.x + offsetAdjust, y: proposedContentOffset.y + offsetAdjust)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let attributesArray = super.layoutAttributesForElements(in: rect) else { return nil }
    
    guard let collectionView = self.collectionView else { return attributesArray }
    
    let visibleRect = CGRect(x: collectionView.contentOffset.x,
                             y: collectionView.contentOffset.y,
                             width: collectionView.bounds.width,
                             height: collectionView.bounds.height)
    
    for attribute in attributesArray {
      apply(layoutAttribute: attribute, for: visibleRect)
    }
    
    return attributesArray
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let attribute = super.layoutAttributesForItem(at: indexPath) else { return nil }
    
    guard let collectionView = self.collectionView else { return attribute }
    
    let visibleRect = CGRect(x: collectionView.contentOffset.x,
                             y: collectionView.contentOffset.y,
                             width: collectionView.bounds.width,
                             height: collectionView.bounds.height)
    
    apply(layoutAttribute: attribute, for: visibleRect)
    
    return attribute
  }
  
  func apply(layoutAttribute attribute: UICollectionViewLayoutAttributes, for visibleRect: CGRect) {
    guard let collectionView = self.collectionView else { return}
    let activeDistance = collectionView.bounds.width
    // skip supplementary kind
    if case UICollectionElementCategory.supplementaryView = attribute.representedElementCategory { return }
    
    let distanceFromVisibleRectToItem: CGFloat = visibleRect.midX - attribute.center.x
    if fabs(distanceFromVisibleRectToItem) < activeDistance {
      let normalizeDistance = (fabs(distanceFromVisibleRectToItem) / activeDistance)

      handlerAttributeWithFactor(attribute, normalizeDistance)
      
    } else {
      handlerAttributeWithFactor(attribute, nil)
    }
  }
  
}
