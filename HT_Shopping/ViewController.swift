//
//  ViewController.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/17.
//

import UIKit

class ViewController: HT_TabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.\
        setUI()
        print(getAppName())
        print(kServersDomain)
    }


}


//MARK:- setUI
extension ViewController {
    
    func setUI() -> Void {
        let normalIcons = ["Home","Classification","Activity","ShopCart","UserCenter"]
        let selectIcons = ["HomeSelect","ClassificationSelect","ActivitySelect","ShopCartSelect","UserCenterSelect"]
        let titles = ["首页","分类","有料","购物车","我的"]
        let colors = ["123121","454545","66aa11","787878","a2a2a2"]
        let vcNamelist = ["HT_HomeViewController", "HT_UserViewController","HT_UserViewController","HT_ShopCartViewController","HT_UserViewController"]
        var vcArray : Array<HT_NavigationViewController> = Array()
        var itemArray : Array<HT_TabBarItem> = Array()
        for i in 0 ..< titles.count {
            let workName = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
            let vcName = vcNamelist[i]
            let vcClass = NSClassFromString("\(workName).\(vcName)") as! UIViewController.Type
            let vc = vcClass.init()
            vc.view.backgroundColor = UIColor.randomColor
            let nav = HT_NavigationViewController(rootViewController: vc)
            vcArray.append(nav)
            let item = HT_TabBarItem(title: titles[i], normalImage: normalIcons[i], selectImage: selectIcons[i], normalColor: "333333", selectColor: "ff0000")
            itemArray.append(item)
        }
        resetTabChildControllers(childControllers: vcArray, tabItems: itemArray)
    }
}
