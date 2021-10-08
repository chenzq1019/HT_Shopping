//
//  HT_LoginViewController.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2021/9/3.
//

import UIKit


class HT_LoginViewController: HT_BaseViewController {
    
    lazy var mTopIconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_logo")
        return imageView
    }()
    lazy var normalLoginView: HT_NormalLoginView = {
        let view = HT_NormalLoginView(frame: CGRect.zero)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        if let param = self.params {
            let title = param["name"]
            self.title = title as? String
        }
        self.edgesForExtendedLayout = [.left,.right,.bottom]
        self.title = "登录"
        self.loadUI()
    }
    


}
//setUI
extension HT_LoginViewController {
    fileprivate func loadUI() -> Void {
        self.view.addSubview(self.mTopIconImageView)
        self.mTopIconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(20)
            make.size.equalTo(CGSize(width: 80 , height: 80))
        }
        self.view.addSubview(self.normalLoginView)
        self.normalLoginView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.mTopIconImageView.snp_bottomMargin).offset(50)
//            make.height.equalTo(100)
        }
    }
}
