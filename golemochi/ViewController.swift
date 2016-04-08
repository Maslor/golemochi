//
//  ViewController.swift
//  golemochi
//
//  Created by Gabriel Freire on 08/04/16.
//  Copyright © 2016 maslor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var golemImage : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageArray = [UIImage]()
        
        for i in 1...4 {
            let image = UIImage(named: "idle\(i).png")
            imageArray.append(image!)
        }
        
        golemImage.animationImages = imageArray
        golemImage.animationDuration = 0.8
        golemImage.animationRepeatCount = 0
        golemImage.startAnimating()
    }
}

