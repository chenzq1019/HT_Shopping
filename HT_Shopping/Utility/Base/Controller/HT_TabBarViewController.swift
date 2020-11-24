//
//  HT_TabBarViewController.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/18.
//

import UIKit

class HT_TabBarViewController: UITabBarController {
    
    lazy var tabContainers: [HT_TabBarItemView] = {
        var array = Array<HT_TabBarItemView>()
        return array
    }()
    
    lazy var tabItems : [HT_TabBarItem] = {
      return Array<HT_TabBarItem>()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutTabBarItems()
    }
    override func viewDidLayoutSubviews() {
        for tabBar in self.tabBar.subviews {
            if tabBar.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabBar.removeFromSuperview()
            }
        }
    }
    
    func resetTabChildControllers(childControllers: [UIViewController], tabItems: [HT_TabBarItem]) -> Void {
        for vc in self.children {
            vc.removeFromParent()
        }
        for vc in childControllers {
            addChild(vc)
        }
        self.tabItems = tabItems
        layoutTabBarItems()
    }
    
 

}

//MARK:- 设置Tab
extension HT_TabBarViewController {
    func layoutTabBarItems() -> Void {
        if self.tabContainers.count > 0 {
            for itemView in self.tabContainers {
                itemView.removeFromSuperview()
            }
            self.tabContainers.removeAll()
        }
       
        for (index, value) in self.tabItems.enumerated() {
            buildItemView(item: value,index: index)
        }
      
    }
    
    func buildItemView(item: HT_TabBarItem ,index: Int) -> Void {
        let itemViewW: CGFloat = kScreenWidth / CGFloat(self.tabItems.count)
        let itemViewH: CGFloat = 49
        let x : CGFloat = itemViewW * CGFloat(index)
        let itemView = HT_TabBarItemView(frame: CGRect(x: x, y: 0, width: itemViewW, height: itemViewH))
        itemView.tag = index
        var status =  false
        if index == 0 {
            status = true
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectClick(recogest:)))
        itemView.addGestureRecognizer(tap)
        itemView.loadTabBarItem(item: item, selected: status)
        tabBar.addSubview(itemView)
        tabContainers.append(itemView)
        
    }
    
    @objc func selectClick(recogest: UIGestureRecognizer) -> Void {
        DispatchQueue.main.async {
            let seletItemView = recogest.view as! HT_TabBarItemView
            self.selectTabBarItemAtIndex(index: seletItemView.tag, animated: true)
        }
    }
    
    func selectTabBarItemAtIndex(index: Int, animated: Bool) -> Void {
        print(self.selectedIndex)
        let oldItemView : HT_TabBarItemView = self.tabContainers[self.selectedIndex]
        let oldItem = self.tabItems[self.selectedIndex]
        print(oldItemView.redDot.text ?? "")
        oldItemView.loadTabBarItem(item: oldItem, selected: false)
        
        let orster : HT_TabBarItemView = self.tabContainers[self.selectedIndex]
        print(orster.redDot.text ?? "")
        self.selectedIndex = index
        let newItemView : HT_TabBarItemView = self.tabContainers[self.selectedIndex] 
        let newItem = self.tabItems[self.selectedIndex]
        newItemView.loadTabBarItem(item: newItem, selected: true)
        if animated {
            newItemView.animationPlay()
        }
    }
}
