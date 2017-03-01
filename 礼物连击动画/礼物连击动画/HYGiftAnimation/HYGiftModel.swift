//
//  HYGiftModel.swift
//  01-礼物连击
//
//  Created by coderwhy on 2017/2/24.
//  Copyright © 2017年 coderwhy. All rights reserved.
//

import UIKit

class HYGiftModel : NSObject {
    var senderName : String = ""
    var senderIcon : String = ""
    var giftIcon : String = ""
    var giftName : String = ""
    
    init(senderName : String, senderIcon : String, giftIcon : String, giftName : String) {
        self.senderName = senderName
        self.senderIcon = senderIcon
        self.giftIcon = giftIcon
        self.giftName = giftName
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        // 1. 将object转成HYGiftModel
        guard let object = object as? HYGiftModel else {
            return false
        }
        
        // 2. 比较senderName/giftName
        if object.senderName == senderName && object.giftName == giftName {
            return true
        }
        
        return false
    }
}
