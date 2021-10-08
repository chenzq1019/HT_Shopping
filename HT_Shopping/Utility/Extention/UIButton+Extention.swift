//
//  UIButton+Extention.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2021/9/10.
//

import Foundation
import UIKit

extension UIButton {
    func startCountDown(interver: Int,title: String,waitTitle:String) -> Void {
        var timeout :Int = interver
        let queue = DispatchQueue.global()
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.schedule(deadline: .now(), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.seconds(0))
        timer.setEventHandler {
            if(timeout <= 0){
                timer.cancel()
                DispatchQueue.main.async {
                    self.setTitle(title, for: .normal)
                    self.isUserInteractionEnabled = true
                }
            }else{
                let seconds = timeout % 60
                let strTime = "\(seconds)秒"
                DispatchQueue.main.async {
                    self.setTitle(strTime + waitTitle, for: .normal)
                    self.isUserInteractionEnabled = false
                }
                timeout -= 1
            }
        }
        timer.resume()
    }
}
