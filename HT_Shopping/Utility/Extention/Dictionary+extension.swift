//
//  Dictionary+extension.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/19.
//

import Foundation
import UIKit
//用于字典的合并，接收的参数是一个键值对时，就可以添加到原有的字典中，并且对原有字典的重复值进行覆盖为新值，不重复则保留
extension Dictionary {
    mutating func merge<S>(_ other: S)
        where S: Sequence, S.Iterator.Element == (key: Key, value: Value){
            for (k ,v) in other {
                self[k] = v
        }
    }
}
