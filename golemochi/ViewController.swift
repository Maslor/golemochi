//
//  ViewController.swift
//  golemochi
//
//  Created by Gabriel Freire on 08/04/16.
//  Copyright © 2016 maslor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var skull3: UIImageView!
    @IBOutlet weak var skull2: UIImageView!
    @IBOutlet weak var skull1: UIImageView!
    @IBOutlet weak var golemImage : MonsterImg!
    @IBOutlet weak var foodImage : DragImage!
    @IBOutlet weak var heartImage : DragImage!
    
    let DIM_ALPHA : CGFloat = 0.2
    let OPAQUE : CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer : NSTimer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skull1.alpha = DIM_ALPHA
        skull2.alpha = DIM_ALPHA
        skull3.alpha = DIM_ALPHA
        
        foodImage.targetElement = golemImage
        heartImage.targetElement = golemImage
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        startTimer()    
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        print("Item Dropped on Character")
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector:#selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        penalties += 1
        if penalties == 1 {
            skull1.alpha = OPAQUE
            skull2.alpha = DIM_ALPHA
        } else if penalties == 2 {
            skull2.alpha = OPAQUE
            skull3.alpha = DIM_ALPHA
        } else if penalties >= 3 {
            skull3.alpha = OPAQUE
        } else {
            skull1.alpha = DIM_ALPHA
            skull2.alpha = DIM_ALPHA
            skull3.alpha = DIM_ALPHA
        }
        
        if penalties >= MAX_PENALTIES {
            gameOver()
        }
    }
    
    func gameOver() {
        timer.invalidate()
        golemImage.playDeathAnimation()
    }
}

