//
//  ContentView.swift
//  StackViewDemo
//
//  Created by 林達也 on 2015/07/18.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import UIKit

@objc
protocol ContentViewDelegate: NSObjectProtocol {
    
    func contentViewDidTouch(view: ContentView)
}

class ContentView: UIView {
    
    @IBOutlet weak var delegate: ContentViewDelegate?
    
    var selected: Bool = false {
        willSet {
            
            if newValue {
                self.layer.borderColor = UIColor.redColor().CGColor
                self.layer.borderWidth = 2
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gesture = UITapGestureRecognizer(target: self, action: "touchAction:")
        self.addGestureRecognizer(gesture)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 10, height: 10)
    }
    
    @objc
    private func touchAction(gesture: UITapGestureRecognizer) {
        
        self.delegate?.contentViewDidTouch(self)
    }
}
