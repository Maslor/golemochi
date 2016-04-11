//
//  MonsterImg.swift
//  golemochi
//
//  Created by Gabriel Freire on 11/04/16.
//  Copyright © 2016 maslor. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg : UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation(){
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        
        for i in 1...4 {
            let image = UIImage(named: "idle\(i).png")
            imageArray.append(image!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        
        for i in 1...5 {
            let image = UIImage(named: "dead\(i).png")
            imageArray.append(image!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
}
