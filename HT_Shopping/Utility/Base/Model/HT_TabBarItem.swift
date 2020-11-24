//
//  HT_TabBarItem.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/18.
//

import UIKit

class HT_TabBarItem: NSObject {
    var title: String?
    var normalImageURL : String?
    var selectImageURL : String?
    var normalColor : String?
    var selectColor : String?
    var normalImage: UIImage?
    var selectImage: UIImage?
    
    
    init(title: String, normalImage: String, selectImage: String,normalColor: String,selectColor: String) {
        super.init()
        self.title = title
//        self.normalImageURL = normalImage
//        self.selectImageURL = selectImage
        self.normalImage = UIImage(named: normalImage)
        self.selectImage =  UIImage(named: selectImage)
        self.normalColor = normalColor
        self.selectColor = selectColor
    }
    
}
