//
//  HYGiftChannelView.swift
//  02-礼物动画
//
//  Created by apple on 16/12/16.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

enum ChannelViewState {
    case idle
    case animating
    case waitToEnding
    case ending
}

class HYGiftChannelView: UIView {
    // MARK: 控件属性
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: HYDigitalLabel!
    
    fileprivate var currentNumber : Int = 0
    fileprivate var cacheNumber : Int = 0
    
    fileprivate var state : ChannelViewState = .idle
    
    var giftModel : HYGiftModel? {
        didSet {
            // 1. 判断模型是否有值
            guard let giftModel = giftModel else {
                return
            }
            
            // 2. 设置HYGiftChannelView中的显示内容
            iconImageView.image = UIImage(named: giftModel.senderIcon)
            senderLabel.text = giftModel.senderName
            giftDescLabel.text = "赠送礼物[\(giftModel.giftName)]"
            giftImageView.image = UIImage(named: giftModel.giftIcon)
            
            // 3. 执行弹出动画
            performShowAnimation()
        }
    }
}


// MARK:- 执行动画
extension HYGiftChannelView {
    fileprivate func performShowAnimation() {
        state = .animating
        // 执行栈道动画
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = 0
            self.alpha = 1.0
        }) { (_) in
            // 1. 显示出来HYDigitalLabel
            self.digitLabel.alpha = 1.0
            
            // 2. 执行缩放动画
            self.performDigitalAnimation()
        }
    }
    
    // 执行连击数缩放动画
    fileprivate func performDigitalAnimation() {
        // 1. 改变label上面显示的内容
        currentNumber += 1
        digitLabel.text = "X\(currentNumber)"
        
        // 2. 执行动画
        digitLabel.startAnimation {
            if self.cacheNumber > 0 {
                self.cacheNumber -= 1
                self.performDigitalAnimation()
            } else {
                self.perform(#selector(self.performDismissAnimation), with: nil, afterDelay: 3.0)
                self.state = .waitToEnding
            }
        }
    }
    
    // 执行结束动画
    @objc fileprivate func performDismissAnimation() {
        self.state = .ending
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0.0
            }) { (_) in
                self.giftModel = nil
                self.currentNumber = 0
                self.digitLabel.alpha = 0
                self.frame.origin.x = -self.bounds.width
                self.state = .idle
        }
    }
}

// MARK:- 设置UI界面
extension HYGiftChannelView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }
}

// MARK:- 对外提供的函数
extension HYGiftChannelView {
    class func loadChannelView() -> HYGiftChannelView {
        return Bundle.main.loadNibNamed("HYGiftChannelView", owner: nil, options: nil)?.first as! HYGiftChannelView
    }
    
    // 添加一次动画到缓存中
    func addOnceToCache() {
        if state == .animating {
            cacheNumber += 1
        } else if state == .waitToEnding {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            performDigitalAnimation()
        }
    }
}
