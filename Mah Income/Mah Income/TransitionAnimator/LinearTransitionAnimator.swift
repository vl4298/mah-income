//
//  LinearTransitionAnimator.swift
//  Mah Income
//
//  Created by Van Luu on 4/17/17.
//  Copyright © 2017 Van Luu. All rights reserved.
//

import UIKit

class LinearTransitionAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
  
  enum DirectionStart {
    case left
    case right
  }
  
  fileprivate var duration: TimeInterval = 0.5
  fileprivate var direction: DirectionStart = .left
  fileprivate var snapView: UIView?
  var isPresenting = false
  
  init(duration: TimeInterval, direction: DirectionStart) {
    self.duration = duration
    self.direction = direction
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let toView = transitionContext.view(forKey: .to), let fromView = transitionContext.view(forKey: .from) else { return }
    let containerView = transitionContext.containerView
    
    if isPresenting {
      snapView = fromView.snapshotView(afterScreenUpdates: true)
      toView.frame = fromView.frame
      containerView.addSubview(toView)
      if case DirectionStart.left = direction {
        toView.transform = CGAffineTransform(translationX: -fromView.frame.size.width, y: 0)
      } else {
        toView.transform = CGAffineTransform(translationX: fromView.frame.size.width, y: 0)
      }
    } else {
      containerView.addSubview(snapView!)
      snapView!.frame = fromView.frame
      snapView!.transform = CGAffineTransform(translationX: -fromView.frame.size.width, y: 0)
    }
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
      
      if self.isPresenting {
        let translationX = self.direction == .left ? fromView.frame.size.width : -fromView.frame.size.width
        toView.transform = CGAffineTransform.identity
        fromView.transform = CGAffineTransform(translationX: translationX, y: 0)
      } else {
        let translationX = self.direction == .left ? -fromView.frame.size.width : fromView.frame.size.width
        self.snapView!.transform = CGAffineTransform.identity
        toView.transform = CGAffineTransform.identity
        fromView.transform = CGAffineTransform(translationX: translationX, y: 0)
      }
    }, completion: { result in
      if !self.isPresenting {
        self.snapView!.removeFromSuperview()
      }
      transitionContext.completeTransition(result)
    })
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    isPresenting = false
    return self
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    isPresenting = true
    return self
  }
  
}
