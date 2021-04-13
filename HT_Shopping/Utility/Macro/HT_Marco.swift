//
//  HT_Marco.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/18.
//

import Foundation
import SnapKit
import Kingfisher
import HandyJSON
import MJRefresh


let kScreenWidth : CGFloat = UIScreen.main.bounds.size.width
let kScreenHeight : CGFloat = UIScreen.main.bounds.size.height

public func iPhoneX() -> Bool{
    guard let w = UIApplication.shared.delegate?.window else {
        return false
    }
    guard #available(iOS 11.0, *) else {
        return false
    }
    return w?.safeAreaInsets.bottom ?? 0.0 > 0.0
}

public func screenScale (width : CGFloat) -> CGFloat {
    return kScreenWidth / 750.0 * width
}

var kStatusBarHeight : CGFloat {
    return iPhoneX() ? 44 : 20
}

var kTabBarHeight : CGFloat {
    return iPhoneX() ? 83 : 49
}

var kNavigationHeight : CGFloat{
    return iPhoneX() ? 88 : 64
}
