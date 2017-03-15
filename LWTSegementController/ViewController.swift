//
//  ViewController.swift
//  LWTSegementController
//
//  Created by liaowentao on 17/3/14.
//  Copyright © 2017年 Haochuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pushTheSegementVC: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func pushTheSegementVC(_ sender: UIButton) {
        let segementVC = LWTSegementViewController()
        segementVC.titleArray = ["社会","科技","娱乐","体育","美女","动物"]
        for (_, _) in segementVC.titleArray.enumerated() {
            let vc = TestViewController()
            segementVC.controllerArray.append(vc)
        }
        self.navigationController?.pushViewController(segementVC, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

