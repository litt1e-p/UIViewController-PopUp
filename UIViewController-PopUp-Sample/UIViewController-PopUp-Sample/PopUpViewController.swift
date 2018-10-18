//
//  PopUpViewController.swift
//  UIViewController-PopUp-Sample
//
//  Created by litt1e-p on 16/7/14.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    deinit {
        print("deinit")
    }
    
    @IBAction func dismissBtnEvent(_ sender: UIButton) {
        dismissPopUpViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
