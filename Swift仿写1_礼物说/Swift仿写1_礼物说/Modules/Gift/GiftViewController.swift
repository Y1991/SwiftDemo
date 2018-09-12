//
//  GiftViewController.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/8/31.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit
//MARK: - 【类】
class GiftViewController: UIViewController {

    // MARK: 1.system method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellow
        
        self.makeUI()
        self.makeFrame()
        self.loadData() //请求数据
        
    
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        self.makeUIFrame()
    }

    
    // MARK: 2.创建视图
    fileprivate func makeUI() {
        self.title = self.tabBarItem.title
        navigationItem.leftBarButtonItem = NSObject.createBarButtonItem("", titleColor: nil, imageName: "navigation_gift_signin", target: self, action: #selector(GiftViewController.gifBtnAction))
            
        navigationItem.rightBarButtonItem = NSObject.createBarButtonItem("", titleColor: nil, imageName: "navigation_gift_search", target: self, action: #selector(GiftViewController.searchBtnAction))
        navigationItem.titleView = titleImageView
        //----------------
    
        self.view.addSubview(self.middleBarView)
        self.view.addSubview(self.scrollView)
        
    }
    
    // MARK: 3.设置Frame
    fileprivate func makeFrame() {
        
        self.middleBarView.snp.makeConstraints({ (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        })
        
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.middleBarView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            
        }
        

    }
    
    // MARK: 4.加载数据
    fileprivate func loadData() {
        /*** 模拟网络请求数据 ***/
        let arr: NSArray = ["精选","海淘","创意生活","送女票","科技范","送爸妈","送基友","送闺蜜","送同事","送宝贝","设计感","文艺范","奇葩搞怪","萌萌哒"]
       
        // 处理核心逻辑 (1)
        self.handleDataLogicForHorizScroll(array: arr)
        
    }
    
    //MARK: 5.属性
    //懒加载 (1)导航title
    fileprivate lazy var titleImageView:UIImageView = {
        let titleImageView = NSObject.createImageView("navigation_gift_title", contentMode: .scaleAspectFit, frame:CGRect(x: 0, y: 0, width: 20.0, height: 20.0))
        return titleImageView
    }()
    
    //懒加载 (2)中间条
    fileprivate lazy var middleBarView:YUHorizScrollView = {
        let view = YUHorizScrollView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 40.0))
        
        view.delegate = self;
        
        return view
    }()
    
    //懒加载 (3)底层滚动View
    fileprivate lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled                  = true
        scrollView.backgroundColor                = UIColor.green
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate                       = self
        
        return scrollView
    }()
    
    

}
//MARK: - 【扩展】点击事件
extension GiftViewController{
    
    // MARK: 1.搜索
    @objc fileprivate func searchBtnAction() {
        //        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    // MARK: 2.
    @objc fileprivate func gifBtnAction() {
        //        NotificationCenter.default.post(name: Notification.Name(rawValue: Notif_Login), object: nil)
        
    }
}

//MARK: - 【扩展】处理核心逻辑
extension GiftViewController{
    //MARK: 1.添加数据源时
    func handleDataLogicForHorizScroll(array: NSArray) -> () {
        // 遍历数组，创建控制器，添加为子视图
        for i in 0..<array.count {
    
            let vc: MerchandiseListViewController = MerchandiseListViewController()
            //外界给控制器赋值
            vc.value(typeString: (array[i] as? String)!)
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            
//            if (i == 0) {
            
                self.scrollView.addSubview(vc.view)
                
                vc.view.snp.makeConstraints({ (make) in
                    make.top.equalToSuperview()
                    make.height.equalToSuperview()
                    make.left.equalTo(UIScreen.main.bounds.size.width*CGFloat(i))
                    make.width.equalTo(UIScreen.main.bounds.size.width)
                })
                
//            }
            
        }
        
        //设置中间滚动条数据源
        self.middleBarView.data = array;
        //设置滚动范围
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width*CGFloat(array.count), height: self.scrollView.height)
    }
    //MARK: 2.触发代理方法时
    func handleDataLogicForHorizScroll(index: NSInteger) -> () {
        var currentIndex = index
        
        if (currentIndex < 0) {
            currentIndex = 0;
        }
            
        else if (currentIndex > self.childViewControllers.count - 1) {
            currentIndex = self.childViewControllers.count - 1;
        }
        
        let vc: MerchandiseListViewController = self.childViewControllers[currentIndex] as! MerchandiseListViewController;
        
        
        if (vc.view.isDescendant(of: self.scrollView))==false {//   判断view是不是指定视图的子视图
            self.scrollView.addSubview(vc.view)
            
            vc.view.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.height.equalToSuperview()
                make.left.equalTo(self.scrollView.snp.left).offset(UIScreen.main.bounds.size.width*CGFloat(currentIndex))
                make.width.equalTo(UIScreen.main.bounds.size.width)
                
            })
        }
        
        
    }
    
}

//MARK: - 【扩展】遵循代理 YUHorizScrollViewDelegate
extension GiftViewController: YUHorizScrollViewDelegate{
    func horizScrollView(_ view: YUHorizScrollView, didSelect index: Int) {
        /**
         *  动态移动滚动视图
         */
        self.scrollView.contentOffset = CGPoint(x: UIScreen.main.bounds.size.width*CGFloat(index), y: 0)
        
        
        self.handleDataLogicForHorizScroll(index: index)
    }
}

//MARK: - 【扩展】遵循代理 UIScrollViewDelegate
extension GiftViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView != self.scrollView) {
            return;
        }
        
        let currentIndex:NSInteger = NSInteger(floor(scrollView.contentOffset.x / UIScreen.main.bounds.size.width));
        self.middleBarView.seleted = currentIndex;
        
        self.handleDataLogicForHorizScroll(index: currentIndex)
        
        
    }
}
