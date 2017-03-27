//
//  Container.swift
//  Capsule
//
//  Created by Florian Krüger on {TODAY}.
//  Copyright © 2017 Capsule. All rights reserved.
//

import UIKit

public protocol Container {}

public extension Container where Self: UIViewController {
    
    // MARK: UIViewController Containment Methods
    
    public func display(contentController content: UIViewController,
                        in view: UIView? = nil,
                        animation: DisplayAnimation = .none,
                        completion: (() -> Void)? = nil)
    {
        let containerView: UIView = view ?? self.view
        addChildViewController(content)
        content.view.frame = containerView.bounds
        content.view.alpha = animation.startAlpha
        containerView.addSubview(content.view)
        
        UIView.animate(withDuration: animation.duration,
                       animations: {
                        content.view.alpha = 1.0
                       },
                       completion: { finished in
                        content.didMove(toParentViewController: self)
                        completion?()
                       })
    }
    
    public func hide(contentController content: UIViewController,
                     animation: HideAnimation = .none,
                     completion: (() -> Void)? = nil)
    {
        content.willMove(toParentViewController: nil)
        
        UIView.animate(withDuration: animation.duration,
                       animations: {
                        content.view.alpha = animation.endAlpha
                       },
                       completion: { finished in
                        content.view.removeFromSuperview()
                        content.removeFromParentViewController()
                        completion?()
                       })
    }
    
    public func cycle(from oldVC: UIViewController,
                      to newVC: UIViewController,
                      animation: TransitionAnimation = .none,
                      completion: (() -> Void)? = nil)
    {
        guard
            let containerView = oldVC.view.superview
            else {
                fatalError("from viewcontroller’s view isn’t part of the view hierarchy")
            }
        
        oldVC.willMove(toParentViewController: nil)
        addChildViewController(newVC)
        
        newVC.view.frame = animation.startFrame(forContainerViewBounds: containerView.bounds)
        
        transition(from: oldVC, to: newVC, duration: animation.duration, options: [],
                   animations: {
                    newVC.view.frame = oldVC.view.frame
                    oldVC.view.frame = animation.endFrame(forContainerViewBounds: containerView.bounds)
        },
                   completion: { finished in
                    oldVC.removeFromParentViewController()
                    newVC.didMove(toParentViewController: self)
                    completion?()
        })
    }
    
}
