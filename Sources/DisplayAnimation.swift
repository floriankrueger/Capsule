//
//  DisplayAnimation.swift
//  Capsule
//
//  Created by Florian Krüger on 27/03/2017.
//  Copyright © 2017 Capsule. All rights reserved.
//

import UIKit

public enum DisplayAnimation {
    
    case none
    case fadeIn(duration: TimeInterval)
    case custom(CustomDisplayAnimation)
    
    var startAlpha: CGFloat {
        switch self {
        case .none:             return 1.0
        case .fadeIn:           return 0.0
        case .custom(let a):    return a.startAlpha
        }
    }
    
    var duration: TimeInterval {
        switch self {
        case .none:                     return 0.0
        case .fadeIn(let duration):     return duration
        case .custom(let a):            return a.duration
        }
    }
    
}

public protocol CustomDisplayAnimation {
    var duration: TimeInterval { get }
    var startAlpha: CGFloat { get }
}
