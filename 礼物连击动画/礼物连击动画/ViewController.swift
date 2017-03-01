//
//  ViewController.swift
//  礼物连击动画
//
//  Created by zhangzhifu on 2017/3/1.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var demoLabel: HYDigitalLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        demoLabel.startAnimation {
            print("动画完成")
        }
    }
}

