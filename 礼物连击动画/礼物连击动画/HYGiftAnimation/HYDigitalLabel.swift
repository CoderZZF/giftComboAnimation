//
//  HYDigitalLabel.swift
//  礼物连击动画
//
//  Created by zhangzhifu on 2017/3/1.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

class HYDigitalLabel: UILabel {
    
    override func draw(_ rect: CGRect) {
        // 1. 获取上下文
        let ctx = UIGraphicsGetCurrentContext()
        
        // 2. 画出第一层文字
        ctx?.setTextDrawingMode(.stroke)
        ctx?.setLineWidth(5)
        ctx?.setLineCap(.round)
        ctx?.setLineJoin(.round)
        textColor = UIColor.blue
        super.draw(rect)
        
        // 3. 画出第二层文字
        ctx?.setTextDrawingMode(.fill)
        ctx?.setLineWidth(2)
        textColor = UIColor.yellow
        super.draw(rect)
    }
    
    func startAnimation(_ completion : @escaping () -> Void) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: {
                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                self.transform = CGAffineTransform.identity
            })
        }) { (_) in
            completion()
        }
    }
    
}
