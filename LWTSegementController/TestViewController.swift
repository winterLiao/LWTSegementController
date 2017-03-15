//
//  TestViewController.swift
//  LWTSegementController
//
//  Created by liaowentao on 17/3/14.
//  Copyright © 2017年 Haochuang. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(red: CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            , green: CGFloat(arc4random_uniform(255))/CGFloat(255.0), blue: CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            , alpha: CGFloat(arc4random_uniform(255))/CGFloat(255.0))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
