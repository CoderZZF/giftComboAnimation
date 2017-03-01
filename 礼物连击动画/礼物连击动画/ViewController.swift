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
    fileprivate var containerView : HYGiftContainerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: 100, width: 250, height: 100)
        let containerView = HYGiftContainerView(frame: frame)
        view.addSubview(containerView)
        self.containerView = containerView
    }
    
    
    @IBAction func gift1() {
        let gift1 = HYGiftModel(senderName: "coderwhy", senderIcon: "icon1", giftIcon: "prop_b", giftName: "跑车")
        containerView.insertGift(gift1)
    }
    
    @IBAction func gift2() {
        let gift2 = HYGiftModel(senderName: "lmj", senderIcon: "icon2", giftIcon: "prop_f", giftName: "啤酒")
        containerView.insertGift(gift2)
    }
    
    @IBAction func gift3() {
        let gift3 = HYGiftModel(senderName: "lnj", senderIcon: "icon2", giftIcon: "prop_g", giftName: "蘑菇")
        containerView.insertGift(gift3)
    }
}

