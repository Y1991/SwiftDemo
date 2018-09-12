//
//  ClassificationViewController.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/8/31.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit

class ClassificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.tabBarItem.title
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        
        
        let arr:Array = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505210930030&di=9fd95a06462b38e8a1120594d8eb2d96&imgtype=0&src=http%3A%2F%2Fpic30.photophoto.cn%2F20140306%2F0008020239049288_b.jpg",
                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505210821835&di=d943fd035aeb35aa998fd92b4490c1e3&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F67%2F06%2F18x58PICSdN_1024.jpg",
                         
                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505210930032&di=04a30e4f19af66406624ad57dbffd365&imgtype=0&src=http%3A%2F%2Fpic24.photophoto.cn%2F20120831%2F0008020276216197_b.jpg",
                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505210930029&di=f32a6ee275f7673f206a96da3671afde&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140406%2F2531170_213111075000_2.jpg",
                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505210930063&di=06e52995912d571dcd11df1b6a489313&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F68%2F56%2F05Z58PICtIN_1024.jpg"]
        let muArr: NSMutableArray = NSMutableArray()
        for i in 0..<arr.count {
            let model: YUCycleModel = YUCycleModel()
            
            model.networkImageName = arr[i];
            model.placeholderImageName = String(format: "%d.jpg",i+1)
            model.index  = i;
            muArr.add(model)
        }
        
        
        let scrollView: YUCycleScrollView = YUCycleScrollView.create(CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width, height: 200), data: Array(muArr) as! [YUCycleModel] )//?[YUCycleModel]
        
        scrollView.backgroundColor = UIColor.green
        self.view.addSubview(scrollView)
        
        
    }

}
