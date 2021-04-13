//
//  HT_UserViewController.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/19.
//

import UIKit

class HT_UserViewController: HT_BaseViewController {
    lazy var topView : UserTopView = {
        let view = UserTopView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: iPhoneX() == true ? 220 : 200))
        view.backgroundColor =  UIColor.red
        return view
    }()
    
    lazy var mTableView : UITableView = {[unowned self] in
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource =  self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.sectionFooterHeight = 10
        tableView.contentInsetAdjustmentBehavior = .never

        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
}

extension HT_UserViewController{
    fileprivate func loadUI() -> Void {
        view.addSubview(self.mTableView)
        self.mTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.mTableView.tableHeaderView = self.topView
//        let navBar = self.navigationController?.navigationBar

    }
}

extension HT_UserViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = "这是第\(indexPath.row)行"
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.01))
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}
