//
//  SubViewController.swift
//  Capsule
//
//  Created by Florian Krüger on 27/03/2017.
//  Copyright © 2017 Capsule. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {
    
    // MARK: Data & Configuration
    
    let letter: String
    let backgroundColor: UIColor
    
    // MARK: UI Elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = self.backgroundColor
        label.text = self.letter
        label.font = UIFont.boldSystemFont(ofSize: 26.0)
        return label
    }()
    
    // MARK: UIViewController
    
    override func loadView() {
        super.loadView()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        var c: NSLayoutConstraint
        
        c = NSLayoutConstraint(item: label,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 1.0,
                               constant: 0.0)
        view.addConstraint(c)
        
        c = NSLayoutConstraint(item: label,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0.0)
        view.addConstraint(c)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
    }
    
    // MARK: Init
    
    init(letter: String, backgroundColor: UIColor) {
        self.letter = letter
        self.backgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }
    
}
