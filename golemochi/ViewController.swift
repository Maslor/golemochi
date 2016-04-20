//
//  ViewController.swift
//  golemochi
//
//  Created by Gabriel Freire on 08/04/16.
//  Copyright © 2016 maslor. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    var happy = false
    var penalties = 0
    var timer : NSTimer!
    var currentItem: UInt32 = 0
    
    var mPlayer: AVAudioPlayer!
    var sfxFood: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skull1.alpha = DIM_ALPHA
        skull2.alpha = DIM_ALPHA
        skull3.alpha = DIM_ALPHA
        foodImage.alpha = DIM_ALPHA
       // heartImage.alpha = DIM_ALPHA
        
        foodImage.targetElement = golemImage
        heartImage.targetElement = golemImage
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        do {
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!
            let url = NSURL(fileURLWithPath: resourcePath)
            try mPlayer = AVAudioPlayer(contentsOfURL: url)
            
            try sfxFood =  AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxDeath =  AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxHeart =  AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxSkull =  AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            mPlayer.prepareToPlay()
            mPlayer.play()
            
            sfxFood.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()    
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        happy = true
        startTimer()
        
        foodImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        heartImage.alpha = DIM_ALPHA
        heartImage.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxFood.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector:#selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        if !happy {
            penalties += 1
            sfxSkull.play()
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
        
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            foodImage.alpha = DIM_ALPHA
            heartImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = false
            heartImage.userInteractionEnabled = true
        } else {
            heartImage.alpha = DIM_ALPHA
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
            heartImage.userInteractionEnabled = false
        }
        
        currentItem = rand
        happy = false
    }
    
    func gameOver() {
        timer.invalidate()
        golemImage.playDeathAnimation()
        sfxDeath.play()
    }
}

