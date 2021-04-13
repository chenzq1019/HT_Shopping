//
//  UserTopView.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/12/7.
//

import UIKit

fileprivate let iconWidth : CGFloat = 70

class UserTopView: UIView {
    lazy var iconImageView : UIImageView = {
        let imagView = UIImageView()
        imagView.layer.cornerRadius = iconWidth / 2.0
        imagView.clipsToBounds = true
        imagView.backgroundColor = UIColor.white
        return imagView
    }()
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "登录/注册"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UserTopView {
    fileprivate func loadUI() -> Void {
        addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-20)
            make.size.equalTo(CGSize(width: iconWidth, height: iconWidth))
        }
        addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImageView.snp_rightMargin).offset(20)
            make.centerY.equalTo(self.iconImageView)
        }
    }
}
