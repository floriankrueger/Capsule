//
//  TransitionAnimation.swift
//  Capsule
//
//  Created by Florian Krüger on 27/03/2017.
//  Copyright © 2017 Capsule. All rights reserved.
//

import UIKit

public enum TransitionAnimation {
    
    case none
    case slideLeft(duration: TimeInterval)
    case slideRight(duration: TimeInterval)
    case custom(CustomTransitionAnimation)
    
    var duration: TimeInterval {
        switch self {
        case .none:                     return 0.0
        case .slideLeft(let duration):  return duration
        case .slideRight(let duration): return duration
        case .custom(let a):            return a.duration
        }
    }
    
    func startFrame(forContainerViewBounds bounds: CGRect) -> CGRect {
        var frame = bounds
        
        switch self {
        case .none:             break
        case .slideLeft:        frame.origin.x = bounds.origin.x - bounds.size.width
        case .slideRight:       frame.origin.x = frame.origin.x + frame.size.width
        case .custom(let a):    frame = a.startFrame(forContainerViewBounds: bounds)
        }
        
        return frame
    }
    
    func endFrame(forContainerViewBounds bounds: CGRect) -> CGRect {
        var frame = bounds
        
        switch self {
        case .none:             break
        case .slideLeft:        frame.origin.x = bounds.origin.x + bounds.size.width
        case .slideRight:       frame.origin.x = bounds.origin.x - bounds.size.width
        case .custom(let a):    frame = a.endFrame(forContainerViewBounds: bounds)
        }
        
        return frame
    }
    
}

public protocol CustomTransitionAnimation {
    var duration: TimeInterval { get }
    func startFrame(forContainerViewBounds bounds: CGRect) -> CGRect
    func endFrame(forContainerViewBounds bounds: CGRect) -> CGRect
}
