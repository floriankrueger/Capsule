//
//  HideAnimation.swift
//  Capsule
//
//  Created by Florian Krüger on 27/03/2017.
//  Copyright © 2017 Capsule. All rights reserved.
//

import UIKit

public enum HideAnimation {
    
    case none
    case fadeOut(duration: TimeInterval)
    case custom(CustomHideAnimation)
    
    var endAlpha: CGFloat {
        switch self {
        case .none:             return 1.0
        case .fadeOut:          return 0.0
        case .custom(let a):    return a.endAlpha
        }
    }
    
    var duration: TimeInterval {
        switch self {
        case .none:                     return 0.0
        case .fadeOut(let duration):    return duration
        case .custom(let a):            return a.duration
        }
    }
    
}

public protocol CustomHideAnimation {
    var duration: TimeInterval { get }
    var endAlpha: CGFloat { get }
}

