//
//  HT_HomeGroup.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/20.
//

import UIKit

class HT_HomeGroup: NSObject {
    var titleColor : String? = "#333333"
    var sectionID : String?
    var cellID: String?
    var iconImge : NSString?
    var titleName : NSString?
    var headSize : CGSize?
    var itemSize : CGSize?
    var priority : Int = 0
    var sectionInset : UIEdgeInsets? = UIEdgeInsets.zero
    var prdList : [AnyObject]? = Array<AnyObject>()
    override init() {
        self.titleName = ""
        self.iconImge = ""
        super.init()
    }
}
