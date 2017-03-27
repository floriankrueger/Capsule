//
//  ViewController.swift
//  Capsule-iOS-Example
//
//  Created by Florian Krüger on 27/03/2017.
//  Copyright © 2017 Capsule. All rights reserved.
//

import UIKit
import Capsule

class ViewController: UIViewController, Capsule.Container {

    // MARK: UI Elements
    
    private lazy var containerView: ContainerView = {
        let view = ContainerView()
        view.borderColor = .red
        return view
    }()
    
    private lazy var buttonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var displayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("DISPLAY", for: .normal)
        button.addTarget(self, action: #selector(displayButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var hideButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("HIDE", for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(hideButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("TOGGLE", for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(toggleButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var subViewControllerA: SubViewController = {
        return SubViewController(letter: "A", backgroundColor: .green)
    }()
    
    private lazy var subViewControllerB: SubViewController = {
        return SubViewController(letter: "B", backgroundColor: .blue)
    }()
    
    private var currentSubViewController: UIViewController? = nil {
        didSet {
            let isNil = currentSubViewController == nil
            displayButton.isEnabled = isNil
            hideButton.isEnabled = !isNil
            toggleButton.isEnabled = !isNil
        }
    }
    
    // MARK: Actions
    
    private func disableAllButtons() {
        displayButton.isEnabled = false
        hideButton.isEnabled = false
        toggleButton.isEnabled = false
    }
    
    @objc private func displayButtonPressed() {
        disableAllButtons()
        display(contentController: subViewControllerA, in: containerView, animation: .fadeIn(duration: 0.25)) {
            self.currentSubViewController = self.subViewControllerA
        }
    }
    
    @objc private func hideButtonPressed() {
        disableAllButtons()
        hide(contentController: currentSubViewController!, animation: .fadeOut(duration: 0.25)) {
            self.currentSubViewController = nil
        }
    }
    
    @objc private func toggleButtonPressed() {
        disableAllButtons()
        if currentSubViewController === subViewControllerA {
            cycle(from: subViewControllerA, to: subViewControllerB, animation: .slideRight(duration: 0.25)) {
                self.currentSubViewController = self.subViewControllerB
            }
        } else if currentSubViewController === subViewControllerB {
            cycle(from: subViewControllerB, to: subViewControllerA, animation: .slideLeft(duration: 0.25)) {
                self.currentSubViewController = self.subViewControllerA
            }
        }
    }
    
    // MARK: UIViewController
    
    override func loadView() {
        super.loadView()
        setupContainerView()
        setupButtonContainer()
        setupDisplayButton()
        setupHideButton()
        setupToggleButton()
    }
    
    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        var c: NSLayoutConstraint
        
        c = NSLayoutConstraint(item: containerView,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 0.0)
        view.addConstraint(c)
        
        c = NSLayoutConstraint(item: containerView,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0.0)
        view.addConstraint(c)
        
        c = NSLayoutConstraint(item: containerView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: topLayoutGuide,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 0.0)
        view.addConstraint(c)
        
        c = NSLayoutConstraint(item: containerView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0.0)
        view.addConstraint(c)
    }
    
    func setupButtonContainer() {
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonContainer)
        
        displayButton.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(displayButton)
        
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(toggleButton)
        
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(hideButton)
        
        var c: NSLayoutConstraint
        
        c = NSLayoutConstraint(item: buttonContainer,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 0.0)
        view.addConstraint(c)
        
        c = NSLayoutConstraint(item: buttonContainer,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0.0)
        view.addConstraint(c)
        
        c = NSLayoutConstraint(item: buttonContainer,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: containerView,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 0.0)
        view.addConstraint(c)
        
        c = NSLayoutConstraint(item: buttonContainer,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: bottomLayoutGuide,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: 0.0)
        view.addConstraint(c)
    }
    
    func setupDisplayButton() {
        var c: NSLayoutConstraint
        
        c = NSLayoutConstraint(item: displayButton,
                               attribute: .right,
                               relatedBy: .equal,
                               toItem: toggleButton,
                               attribute: .left,
                               multiplier: 1.0,
                               constant: -20.0)
        buttonContainer.addConstraint(c)
        
        c = NSLayoutConstraint(item: displayButton,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: buttonContainer,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0.0)
        buttonContainer.addConstraint(c)
    }
    
    func setupToggleButton() {
        var c: NSLayoutConstraint
        
        c = NSLayoutConstraint(item: toggleButton,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: buttonContainer,
                               attribute: .centerX,
                               multiplier: 1.0,
                               constant: 0.0)
        buttonContainer.addConstraint(c)
        
        c = NSLayoutConstraint(item: toggleButton,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: buttonContainer,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0.0)
        buttonContainer.addConstraint(c)
        
        c = NSLayoutConstraint(item: toggleButton,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: displayButton,
                               attribute: .width,
                               multiplier: 1.0,
                               constant: 0.0)
        buttonContainer.addConstraint(c)
        
        c = NSLayoutConstraint(item: toggleButton,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: hideButton,
                               attribute: .width,
                               multiplier: 1.0,
                               constant: 0.0)
        buttonContainer.addConstraint(c)
    }
    
    func setupHideButton() {
        var c: NSLayoutConstraint
        
        c = NSLayoutConstraint(item: hideButton,
                               attribute: .left,
                               relatedBy: .equal,
                               toItem: toggleButton,
                               attribute: .right,
                               multiplier: 1.0,
                               constant: 20.0)
        buttonContainer.addConstraint(c)
        
        c = NSLayoutConstraint(item: hideButton,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: buttonContainer,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0.0)
        buttonContainer.addConstraint(c)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let modal = UIViewController()
//        modal.view.backgroundColor = .green
//        
//        display(contentController: modal)
    }

}

