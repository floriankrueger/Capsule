//
//  ContainerView.swift
//  Capsule
//
//  Created by Florian Krüger on 27/03/2017.
//  Copyright © 2017 Capsule. All rights reserved.
//

import UIKit

final class ContainerView: UIView {
    
    var borderColor: UIColor = .black {
        didSet {
            border.strokeColor = borderColor.cgColor
            setNeedsDisplay()
        }
    }
    
    private lazy var border: CAShapeLayer = {
        let border = CAShapeLayer()
        border.strokeColor = self.borderColor.cgColor
        border.fillColor = nil
        border.lineWidth = 2.0
        border.lineDashPattern = [4, 2]
        return border
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        border.path = UIBezierPath(rect: bounds).cgPath
        border.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(border)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
