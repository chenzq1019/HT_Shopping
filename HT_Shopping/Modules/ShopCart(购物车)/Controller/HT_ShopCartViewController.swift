//
//  HT_ShopCartViewController.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/24.
//

import UIKit

class HT_ShopCartViewController: HT_BaseViewController {
    
    lazy var mTableView : UITableView  = { [unowned self] in
        let tableView  =  UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        // Do any additional setup after loading the view.
    }
    
}

extension HT_ShopCartViewController {
    func loadUI() -> Void {
        self.view.addSubview(self.mTableView)
        self.mTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}

extension HT_ShopCartViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = UIColor.randomColor
        return cell
    }
}
