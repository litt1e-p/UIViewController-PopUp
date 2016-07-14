//
//  ViewController.swift
//  UIViewController-PopUp-Sample
//
//  Created by litt1e-p on 16/7/14.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBAction func popUpBtnEvent(sender: AnyObject) {
        let s                   = UIScreen.mainScreen().bounds.size
        let pv                  = PopUpViewController()
        pv.view.frame           = CGRectMake(0, 0, s.width - 2 * 40, s.height * 0.6)
        pv.view.backgroundColor = .whiteColor()
        popUpEffectType         = .FlipDown //.ZoomIn(default)/.ZoomOut/.FlipUp/.FlipDown
        presentPopUpViewController(pv)
    }
}

