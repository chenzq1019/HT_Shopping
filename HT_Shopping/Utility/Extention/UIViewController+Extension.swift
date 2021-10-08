//
//  UIViewController+Extension.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2021/9/3.
//

import Foundation
import UIKit

protocol HTViewControllerProtocol {
    var params : [String:Any]? {get set}
    static var currentViewController : UIViewController { get}
    func push(name: String,isNib:Bool,params:[String:Any]?)
}

extension UIViewController:HTViewControllerProtocol {
    //动态添加属性
    private struct AssociatedKey {
           static var identifier: String = "identifier"
    }
    
    public var params: [String : Any]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.identifier) as? [String : Any]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.identifier, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    func push(name: String, isNib: Bool, params: [String : Any]?) {
        if name.count <= 0 {
            return
        }
        let workName = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
        let anyobjectType : AnyObject.Type = NSClassFromString("\(workName).\(name)")!
        
        guard let classVC = anyobjectType as? UIViewController.Type  else {
            return
        }
        let vc = classVC.init()
        if let data = params {
            vc.params = data
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static var currentViewController: UIViewController {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let rootVc = window?.rootViewController
        return UIViewController.currentViewController(from: rootVc!)
    }
    static func currentViewController(from: UIViewController) -> UIViewController{
        
        if from.isKind(of: UINavigationController.self) {
            let navigationController : UINavigationController = from as! UINavigationController
            return UIViewController.currentViewController(from: navigationController.viewControllers.last!)
        }else if(from.isKind(of: UITabBarController.self)){
            let tabViewController : UITabBarController = from as! UITabBarController
            return UIViewController.currentViewController(from: tabViewController.selectedViewController!)
        }else if(from.presentedViewController != nil){
            return UIViewController.currentViewController(from: from.presentedViewController!)
        }else{
            return from
        }
    }
    
    
}
