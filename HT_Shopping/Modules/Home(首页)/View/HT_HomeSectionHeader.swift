//
//  HT_HomeSectionHeader.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/20.
//

import UIKit

enum HeaderType {
    case Middle
    case Left
}

class HT_HomeSectionHeader: UICollectionReusableView {
    
    var kiconView : UIImageView = UIImageView()
    var testImageView : UIImageView = UIImageView()
    var kbackView : UIImageView = UIImageView()
    var kcontainerView : UIView = UIView()
    lazy var titlLable : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.text = "header头部"
        return label
    }()
    var sectionModel : HT_HomeGroup? {
        didSet {
            //首先使用guard 判断是否有值，如果没有值就return
            guard let model = sectionModel else {
                return
            }
            //使用if let 将可选变量转为不可选变量。用于图片展示
            if let iconUrl = model.iconImge , iconUrl.length > 0 && iconUrl.hasPrefix("http"){
                self.kiconView.kf.setImage(with: URL(string: iconUrl as String),placeholder: UIImage(named: "Recommend_icon"))
            }else {
                self.kiconView.image = UIImage(named: "Recommend_icon")
            }
            self.titlLable.text =  model.titleName as String?
            self.titlLable.textColor = UIColor(rgb: (sectionModel?.titleColor!)!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
 
     
       

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HT_HomeSectionHeader {
    func loadUI() -> Void {
        self.backgroundColor = UIColor.white
        self.kcontainerView.addSubview(self.kiconView)
        self.kcontainerView.addSubview(self.titlLable)
        //布局kcontainerView
        self.kiconView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20.0, height: 20.0))
            make.left.top.bottom.equalTo(self.kcontainerView)
        }
        self.titlLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.kiconView.snp_rightMargin).offset(15)
            make.top.bottom.right.equalTo(self.kcontainerView)
        }
        
        addSubview(self.kcontainerView)
        self.kcontainerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        
    }
}
