//
//  HT_TabBarItemView.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/18.
//

import UIKit

let kIconWidth : CGFloat = 25
let kIconHeight : CGFloat = 25

class HT_TabBarItemView: UIView {

    var redDot : UILabel = {
        return UILabel()
    }()
    lazy var titlLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    public func loadTabBarItem(item:HT_TabBarItem,selected: Bool) -> Void {
        if selected {
            if let url = item.selectImageURL {
                self.iconImage.kf.setImage(with: URL(string: url),placeholder: item.selectImage)
            }else{
                self.iconImage.image = item.selectImage
            }
            self.titlLabel.textColor = UIColor(rgb: item.selectColor!)
        }else{
            if let url = item.normalImageURL {
                self.iconImage.kf.setImage(with: URL(string: url))
            }else{
                self.iconImage.image = item.normalImage
            }
            self.titlLabel.textColor = UIColor(rgb: item.normalColor!)
        }
        self.titlLabel.text = item.title!;
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK:-
extension HT_TabBarItemView {
    func setUI() -> Void {
        self.addSubview(self.titlLabel)
        self.addSubview(self.iconImage)
        self.iconImage.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: kIconWidth, height: kIconHeight))
            make.top.equalTo(self).offset(5)
            make.centerX.equalTo(self)
        }
        self.titlLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.iconImage.snp_bottomMargin).offset(4)
            make.bottom.equalTo(self)
        }
    }
}

extension HT_TabBarItemView{
    func animationPlay() -> Void {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0,1.4,0.9,1.2,0.95,1.0]
        animation.duration = 0.5
        iconImage.layer.add(animation, forKey: nil)
    }
}
