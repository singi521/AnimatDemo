//
//  ViewController.swift
//  AnimatTest
//
//  Created by Vincent on 2015/5/23.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    
    var images = [UIImageView]()
    var timer:NSTimer!
    var ns = 0.3
    
    @IBAction func onTappedReset(sender: AnyObject){
        
        for i in 0 ..< 8 {
            if i == 0 {
                images[i].image = UIImage(named: "cutline_2")
            }else{
                images[i].image = UIImage(named: "cutline_1")
            }
        }
    }
    
    @IBAction func onTappedButton(sender: AnyObject) {
        /*
        image1.startAnimating()
        image2.startAnimating()
        image3.startAnimating()
        image4.startAnimating()
        image5.startAnimating()
        image6.startAnimating()
        image7.startAnimating()
        image8.startAnimating()
        */
        
        
        idx = 0
        timer = NSTimer.scheduledTimerWithTimeInterval(ns/8, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    var idx = 0
    
    func update() {
        // Something cool
        println("update:index\(idx)")
        if idx < 8 {
            images[idx].startAnimating()
            
            if idx == 7 {
                //images[0].stopAnimating()
                //images[0].image = UIImage(named: "cutline_8")
                //images[1].stopAnimating()
                //images[1].image = UIImage(named: "cutline_7")
                
                for i in 0 ..< 8 {
                    images[i].stopAnimating()
                    
                    var finalImage:UIImage = UIImage(named: "cutline_1")!
                    var imgIdx = idx+1-i //7+1-{0~8}
                    
                    if i >= 1 {
                        imgIdx+=1
                    }
                    println("[\(i)]cutline_\(imgIdx)")
                    
                    if i < 7 {
                        finalImage = UIImage(named: "cutline_\(imgIdx)")!
                    }
                    
                    images[i].image = finalImage
                    
                }
            }
            
            
            
        }else {
            //images[idx-7].stopAnimating()
            //images[idx-7].image = UIImage(named: "cutline_8")
            timer.invalidate()
        }
        
        
        idx++
        
        if idx > 8 {
            println("stop")
            idx = 0
            timer.invalidate()
            //images[6].image = UIImage(named: "cutline_3")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = [image1,image2,image3,image4,image5,image6,image7,image8]
        // Do any additional setup after loading the view, typically from a nib.
        var frameImgs = [UIImage]()
        for i in 1 ..< 9 {
            if i == 2 {
                continue
            }
            frameImgs.append(UIImage(named: "cutline_\(i)")!)
        }

        image1.animationImages = frameImgs
        image2.animationImages = frameImgs
        image3.animationImages = frameImgs
        image4.animationImages = frameImgs
        image5.animationImages = frameImgs
        image6.animationImages = frameImgs
        image7.animationImages = frameImgs
        image8.animationImages = frameImgs
        
        image1.animationDuration = ns
        image2.animationDuration = ns
        image3.animationDuration = ns
        image4.animationDuration = ns
        image5.animationDuration = ns
        image6.animationDuration = ns
        image7.animationDuration = ns
        image8.animationDuration = ns
        
        
        image1.animationRepeatCount = 1
        image2.animationRepeatCount = 1
        image3.animationRepeatCount = 1
        image4.animationRepeatCount = 1
        image5.animationRepeatCount = 1
        image6.animationRepeatCount = 1
        image7.animationRepeatCount = 1
        image8.animationRepeatCount = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

