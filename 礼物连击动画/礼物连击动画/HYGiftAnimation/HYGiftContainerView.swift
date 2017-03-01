//
//  HYGiftContainerView.swift
//  01-礼物连击
//
//  Created by coderwhy on 2017/2/24.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class HYGiftContainerView: UIView {
    // MARK: 属性 作用: 缓存
    fileprivate lazy var channelViews : [HYGiftChannelView] = [HYGiftChannelView]()
    fileprivate lazy var cacheGiftModels : [HYGiftModel] = [HYGiftModel]()
    
    // MARK: 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HYGiftContainerView {
    fileprivate func setupUI() {
        // 1.根据当前的渠道数，创建HYGiftChannelView
        let w : CGFloat = frame.width
        let h : CGFloat = 40
        let x : CGFloat = 0
        for i in 0..<2 {
            let y : CGFloat = (h + 10) * CGFloat(i)
            let channelView = HYGiftChannelView.loadChannelView()
            channelView.frame = CGRect(x: x, y: y, width: w, height: h)
            channelView.alpha = 0.0
            addSubview(channelView)
            channelViews.append(channelView)
            
            channelView.animationFinishedCallBack = {(channelView) in
                // 1. 判断缓存中是否有数据
                if self.cacheGiftModels.count == 0 {
                    return
                }
                
                // 2. 取出第一条数据
                let firstGiftModel = self.cacheGiftModels[0]
                self.cacheGiftModels.removeFirst()
                
                var cacheNumber = 0
                // 找出cacheGiftModels中与正在播放的礼物相同的个数,设置缓存数加1
                for i in (0..<self.cacheGiftModels.count).reversed() {
                    let giftModel = self.cacheGiftModels[i]
                    if giftModel.isEqual(firstGiftModel) {
                        cacheNumber += 1
                        self.cacheGiftModels.remove(at: i)
                    }
                }
                
                // 3. 让channelView执行firstGiftModel动画
                channelView.cacheNumber = cacheNumber
                channelView.giftModel = firstGiftModel
            }
        }
    }
}

extension HYGiftContainerView {
    func insertGift(_ giftModel : HYGiftModel) {
        // 1. 判断是否有相同的人赠送相同的礼物正在执行动画
        if let channelView = checkoutSameGift(giftModel) {
            channelView.addOnceToCache()
            return
        }
        
        // 2. 判断是否有闲置的栈道用于执行动画
        if let channelView = checkoutIdleChannelView() {
            channelView.giftModel = giftModel
            return
        }
        
        // 3. 将礼物先缓存起来
        cacheGiftModels.append(giftModel)
    }
}


extension HYGiftContainerView {
    // 检测是否是同一个人赠送相同的礼物
    fileprivate func checkoutSameGift(_ newGift : HYGiftModel) -> HYGiftChannelView? {
        for channelView in channelViews {
            if newGift.isEqual(channelView.giftModel) && channelView.state != .ending {
                return channelView
            }
        }
        
        return nil
    }
    
    fileprivate func checkoutIdleChannelView() -> HYGiftChannelView? {
        for channelView in channelViews {
            if channelView.state == .idle {
                return channelView
            }
        }
        
        return nil
    }
}
