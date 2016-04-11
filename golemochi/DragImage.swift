//
//  DragImage.swift
//  golemochi
//
//  Created by Gabriel Freire on 08/04/16.
//  Copyright © 2016 maslor. All rights reserved.
//

import Foundation
import UIKit

class DragImage : UIImageView {
    var originalPosition : CGPoint!
    var targetElement: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.locationInView(self.superview)
            self.center = CGPoint(x: position.x, y: position.y)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first, let target = targetElement {
            let position = touch.locationInView(self.superview)
            if CGRectContainsPoint(target.frame, position) {
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
            }
        }
        self.center = originalPosition
    }
}