//
//  ViewController.swift
//  StackViewDemo
//
//  Created by 林達也 on 2015/07/13.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import UIKit

enum AlignmentHorizontal: String {
    case Fill, Top, Center, Bottom
    
    private func updateStack(v: UIStackView) {
        func alignment() -> UIStackViewAlignment {
            switch self {
            case .Fill:
                return .Fill
            case .Top:
                return .Top
            case .Center:
                return .Center
            case .Bottom:
                return .Bottom
            }
        }
        v.alignment = alignment()
    }
}

enum Distribution: String {
    case Fill, FillEqually, FillProportionally, EqualSpacing, EqualCentering
    
    private func updateStack(v: UIStackView) {
        func distribution() -> UIStackViewDistribution {
            switch self {
            case Fill:
                return .Fill
            case FillEqually:
                return .FillEqually
            case FillProportionally:
                return .FillProportionally
            case EqualSpacing:
                return .EqualSpacing
            case .EqualCentering:
                return .EqualCentering
            }
        }
        v.distribution = distribution()
    }
}

enum Axis: String {
    case Horizontal, Vertical
    
    private func updateStack(v: UIStackView) {
        func axis() -> UILayoutConstraintAxis {
            switch self {
            case Horizontal:
                return .Horizontal
            case Vertical:
                return .Vertical
            }
        }
        v.axis = axis()
    }
}

class ViewController: UIViewController {

    
    @IBOutlet weak var stackView0: UIStackView! {
        willSet {
            
        }
    }
    
    @IBOutlet weak var controlPane: UIView! {
        willSet {
            newValue.layer.borderWidth = 0.5
            newValue.layer.borderColor = UIColor.redColor().CGColor
        }
    }
    
    @IBOutlet weak var contentHiddenSwitch: UISwitch!
    
    //
    var axis: Axis = .Horizontal {
        willSet {
            animate {
                newValue.updateStack(self.stackView0)
            }
        }
    }
    
    var alignment: AlignmentHorizontal = .Top {
        willSet {
            animate {
                newValue.updateStack(self.stackView0)
            }
        }
    }
    
    var distribution: Distribution = .EqualCentering {
        willSet {
            animate {
                newValue.updateStack(self.stackView0)
            }
        }
    }
    
    var selectedIndex: Int? {
        willSet {
            
            for view in self.stackView0.arrangedSubviews as! [ContentView] {
                view.selected = false
            }
            
            guard let index = newValue else {
                return
            }
            guard let view = self.stackView0.arrangedSubviews[index] as? ContentView else {
                return
            }
            
            view.selected = true
        }
    }
    
    var selectedView: ContentView? {
        guard let idx = self.selectedIndex else {
            return nil
        }
        return self.stackView0.arrangedSubviews[idx] as? ContentView
    }
    
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        for view in self.stackView0.arrangedSubviews as! [ContentView] {
            view.delegate = self
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateContentView() {
        
        guard let view = self.selectedView else {
            return
        }
        
        self.contentHiddenSwitch.on = view.hidden
    }
}

extension ViewController: ContentViewDelegate {
    
    func contentViewDidTouch(view: ContentView) {
        
        self.selectedIndex = self.stackView0.arrangedSubviews.indexOf(view)
        
        self.updateContentView()
    }
}

extension ViewController {
    
    
    @IBAction func axisChangeAction(sender: UISegmentedControl) {
        
        self.axis = Axis(rawValue: sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!)!
    }
    
    @IBAction func alignmentChangeAction(sender: UISegmentedControl) {
        
        self.alignment = AlignmentHorizontal(rawValue: sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!)!
    }
    
    @IBAction func distributionChangeAction(sender: UISegmentedControl) {
        
        self.distribution = Distribution(rawValue: sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!)!
    }
}

extension ViewController {
    
    @IBAction func hiddenAction(sender: UISwitch) {
        
        animate {
            self.selectedView?.hidden = sender.on
        }
    }
}

extension ViewController {
    
    @IBAction func reset(sender: AnyObject) {
        
        animate {
            for view in self.stackView0.arrangedSubviews as! [ContentView] {
                view.hidden = false
            }
        }
        
        self.contentHiddenSwitch.setOn(false, animated: true)
    }
}

