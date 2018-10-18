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
        let s                   = UIScreen.main.bounds.size
        let pv                  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        pv.view.frame           = CGRect(x:0, y:0, width: s.width - 2 * 40, height: s.height * 0.6)
        pv.view.backgroundColor = .white
        popUpEffectType         = .flipDown //.zoomIn(default)/.zoomOut/.flipUp/.flipDown
        presentPopUpViewController(pv)
    }
}

