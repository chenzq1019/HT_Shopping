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
    var iconImge : String?
    var titleName : String?
    var headSize : CGSize?
    var itemSize : CGSize?
    var priority : Int = 0
    var backgroudimage : String?
    var sectionInset : UIEdgeInsets? = UIEdgeInsets.zero
    var prdList : [Any]? = Array<Any>()
    override init() {
        self.titleName = ""
        self.iconImge = ""
        super.init()
    }
    init(sectionID :String,cellID: String,headSize: CGSize,itemSize: CGSize){
        super.init()
        self.sectionID = sectionID
        self.cellID = cellID
        self.headSize = headSize
        self.itemSize = itemSize
    }
}
