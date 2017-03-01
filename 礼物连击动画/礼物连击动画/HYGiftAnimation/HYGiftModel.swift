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
}
