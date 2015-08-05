//
//  CutAnimateVIew.swift
//  AnimatTest
//
//  Created by vincentyen on 5/27/15.
//  Copyright (c) 2015 Vincent. All rights reserved.
//

import UIKit

class CutAnimateVIew: UIView {
    var scale:CGFloat = 1.0
    var imageSize:CGSize = CGSizeMake(40, 40)
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    
    var cutImg = UIImageView(image: UIImage(named: "cutline_bb")!)
    
    var images = [UIImageView]()
    var timer:NSTimer!
    var ns = 0.3
    var idx = 0
    
    var callback: (() -> Void)?
    
    let allImageCount = 8
    
    override func awakeFromNib() {
        
        self.scale = UIScreen.mainScreen().bounds.width / 320.0
        println("screen:\(UIScreen.mainScreen().bounds.width) scale:\(self.scale)")
        self.imageSize = CGSizeMake(CGFloat(40 * scale), CGFloat(40 * scale))
        self.animatCutInit()
        
        self.cutImg.frame.size = CGSizeMake(CGFloat(40 * scale), CGFloat(40 * scale))
        
        self.addSubview(cutImg)
        println("self.imageSize:\(self.imageSize)")
    }
    
    init(cb:() -> Void) {
        self.callback = cb
        super.init(frame: CGRectMake(0, 0, 320, 40))
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for i in 0 ..< allImageCount {
            images[i].frame.size    = imageSize
            images[i].frame.origin  = CGPointMake(CGFloat(i) * imageSize.width, 0)
            println("x:\(images[i].frame.origin.x)")
        }
    }
    
    func animatCutInit(){
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.addGestureRecognizer(swipeRight)
        
        
        images = [image1,image2,image3,image4,image5,image6,image7,image8]
        // Do any additional setup after loading the view, typically from a nib.
        var frameImgs = [UIImage]()
        for i in 1 ..< allImageCount+1 {
            frameImgs.append(UIImage(named: "cutline_\(i)")!)
        }
        
        for i in 0 ..< allImageCount {
            images[i].animationImages = frameImgs
            images[i].animationDuration = ns
            images[i].animationRepeatCount = 1
        }
        animatCutReset()
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Swiped right")
                self.animatCutStart()
            default:
                break
            }
        }
    }
    
    
    
    func animatCutReset(){
        self.cutImg.frame.origin.x = 0
        idx = 0
        for i in 0 ..< allImageCount {
            if i == 0 {
                //images[i].image = UIImage(named: "cutline_default")
                images[i].image = UIImage(named: "cutline_1")
            }else{
                images[i].image = UIImage(named: "cutline_1")
            }
        }
    }
    
    func animatCutStart(){
        if timer != nil && timer.valid == true {
            return
        }
        
        UIView.animateKeyframesWithDuration(0.4, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeDiscrete, animations: { () -> Void in
            self.cutImg.frame.origin.x = self.image8.frame.origin.x
        }, completion: nil)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(ns/8, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func animatComplete(){
        println("animatComplete")
        self.callback?()
    }
    
    
    func update() {
        
        if idx < allImageCount {
            images[idx].startAnimating()
            
            if idx == allImageCount-1 {
                for i in 0 ..< allImageCount {
                    images[i].stopAnimating()
                    var finalImage:UIImage = UIImage(named: "cutline_1")!
                    var imgIdx = idx+1-i //7+1-{0~8}
                    
                    if i >= 1 {
                        imgIdx+=1
                    }
                    println("[\(i)]cutline_\(imgIdx)")
                    
                    if i < allImageCount {
                        finalImage = UIImage(named: "cutline_\(imgIdx)")!
                    }
                    
                    images[i].image = finalImage
                    
                }
            }
        }else {
            timer.invalidate()
            self.animatComplete()
        }
        
        
        idx++
        
        if idx > allImageCount {
            //println("stop")
            idx = 0
            timer.invalidate()
        }
    }
}
