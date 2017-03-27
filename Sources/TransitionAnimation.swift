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
    case crossfade(duration: TimeInterval)
    case custom(CustomTransitionAnimation)
    
    var duration: TimeInterval {
        switch self {
        case .none:                     return 0.0
        case .slideLeft(let duration):  return duration
        case .slideRight(let duration): return duration
        case .crossfade(let duration):  return duration
        case .custom(let a):            return a.duration
        }
    }
    
    func startFrame(forContainerViewBounds bounds: CGRect) -> CGRect {
        var frame = bounds
        
        switch self {
        case .none:             break
        case .slideLeft:        frame.origin.x = bounds.origin.x - bounds.size.width
        case .slideRight:       frame.origin.x = frame.origin.x + frame.size.width
        case .crossfade:        break
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
        case .crossfade:        break
        case .custom(let a):    frame = a.endFrame(forContainerViewBounds: bounds)
        }
        
        return frame
    }
    
    var startAlpha: CGFloat {
        switch self {
        case .none:             return 1.0
        case .slideLeft:        return 1.0
        case .slideRight:       return 1.0
        case .crossfade:        return 0.0
        case .custom(let a):    return a.startAlpha
        }
    }
    
    var endAlpha: CGFloat {
        switch self {
        case .none:             return 1.0
        case .slideLeft:        return 1.0
        case .slideRight:       return 1.0
        case .crossfade:        return 1.0
        case .custom(let a):    return a.endAlpha
        }
    }
    
}

public protocol CustomTransitionAnimation: CustomDisplayAnimation, CustomHideAnimation {}
