//
//  MerchandiseListViewController.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/3.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit
// MARK: - 【类】
class MerchandiseListViewController: UIViewController {
    //MARK: 0.System method
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = NSObject.randomColor()
        
        self.makeUI()
        self.makeFrame()
        self.loadData()
    }
    
    //MARK: 1.UI
    fileprivate func makeUI(){
        self.view.addSubview(self.tableView)
        
        // 创建头视图
        let tableHeaderView = MerchandiseListTableHeaderView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 100+200))
        tableHeaderView.typeString = self.typeString
        self.tableView.tableHeaderView = tableHeaderView
    }
    
    //MARK: 2.Frame
    fileprivate func makeFrame(){
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        
    }
    
    //MARK: 3.加载数据
    fileprivate func loadData(){
        
        // 头视图数据
        let two = self.tableView.tableHeaderView as?MerchandiseListTableHeaderView
        
        let mDic = NSMutableDictionary(capacity: 0)
        mDic.addEntries(from: ["loopImage":"head.jpeg"])
        let mArr = NSMutableArray(capacity: 0)
        for _ in 0..<10 {
            mArr.add(NSString.init(format: "goods_%d.jpg", arc4random()%9))
        }
        mDic.addEntries(from: ["horizScroll":mArr])
        two?.data(mDic)
        
        // cell数据源
        for _ in 0..<10 {
            let dic: NSDictionary = ["midImageName"     : NSString.init(format: "goods_%d.jpg", arc4random()%9),
                                     "tag"      :"礼物",
                                     "store"    : "不打烊的礼物店",
                                     "shopOwner" :"于广权",
                                     "headImg"   :"head.jpeg",
                                     "title"    :"第83期：古风墨色|许你一场最美的意外",
                                     "love"     :"87753"]
            self.dataArray.add(dic)
        }
        
        self.tableView.reloadData()

    }
    
    //MARK: 4.懒加载
    // (1)表视图
    fileprivate lazy var tableView:UITableView = {
        
        let tableView = NSObject.createTableView(CGRect(), delegate: self, cellClass: MerchandiseListTableViewCell.self, cellIdentifier: "MerchandiseListTableViewCell")
        return tableView
    }()
    // (2)数据源
    fileprivate lazy var dataArray:NSMutableArray = {
        let dataArray = NSMutableArray(capacity: 0)
        return dataArray
    }()
    

    //MARK: 5.存储属性
    fileprivate var typeString: String?
    

  
}
// MARK: - 【扩展】外界赋值
extension MerchandiseListViewController{
    func value(typeString: String) -> () {
        self.typeString = typeString
    }
}

// MARK: - 【扩展】实现协议 MerchandiseListTableViewCellDelegate
extension MerchandiseListViewController: MerchandiseListTableViewCellDelegate{
    func merchandiseListTableViewCell(_ cell: MerchandiseListTableViewCell, didSelect string: NSString) {
        
    }
}
// MARK: - 【扩展】实现协议 UITableViewDelegate
extension MerchandiseListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        _ = tableView.reLayoutForCell(indexPath )
        
    }
}
// MARK: - 【扩展】实现协议 UITableViewDataSource
extension MerchandiseListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 复用cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MerchandiseListTableViewCell", for: indexPath) as! MerchandiseListTableViewCell
        
        cell.value(dictionary: self.dataArray[indexPath.row] as! NSDictionary)
        cell.delegate = self
        
        
        cell.repairTableCell()
        return cell
    }
    
}
