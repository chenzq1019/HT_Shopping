//
//  UIColor+Extention.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/18.
//

import Foundation
import UIKit

extension UIColor{
    public convenience init(rgb : String){
        var cString = rgb.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        _ = (cString as NSString).length

        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt64 = 0,g:UInt64 = 0,b:UInt64 = 0
        //进行转换
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
        
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
    
    public convenience init(rgb : String, alpha : CGFloat) {
        var cString = rgb.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        _ = (cString as NSString).length

        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt64 = 0,g:UInt64 = 0,b:UInt64 = 0
        //进行转换
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
        
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
    class var randomColor : UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
