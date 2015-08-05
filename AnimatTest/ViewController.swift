//
//  ViewController.swift
//  AnimatTest
//
//  Created by Vincent on 2015/5/23.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cutAnimateView: CutAnimateVIew!
    @IBAction func onTappedReset(sender: AnyObject){
        cutAnimateView.animatCutReset()
    }
    
    @IBAction func onTappedButton(sender: AnyObject) {
        //cutAnimateView.animatCutStart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cutAnimateView.callback = self.callBack
    }
    
    func callBack(){
        println("Yes")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

