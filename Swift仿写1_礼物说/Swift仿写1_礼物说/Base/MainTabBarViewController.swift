//
//  MainTabBarViewController.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/8/31.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit
// MARK: - 【类】
class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 修复导航条引起的异常
        NSObject.repairNavigationBar(self)
        

        // 配置tabBar
        self.makeTabBar()
 
 
    }
    

}
// MARK: - 【扩展】私有方法
extension MainTabBarViewController{


    
    //MARK: 配置TabBar的显示状态
    /// 配置TabBar的显示状态
    func makeTabBar() -> () {
        
        // 设置tabBar控制器上导航条上的title，只能通过下面的方法进行设置，不能通过子控制器来进行设置
        self.title = kTabBar_gift_title as String //在代理方法中进行更新
        
        // 设置显示（字体颜色和字号）
        NSObject.makeTabBarItemAppearance((UIColor.lightGray, UIFont.systemFont(ofSize: 13)), selectedSet: (UIColor.red, UIFont.systemFont(ofSize: 13)), tabBarVC: self)
        
        // 设置代理
        self.delegate = self as UITabBarControllerDelegate
        
        
        // 添加子控制器需要的数据
        let childData = NSObject.handleDataForChildViewControllerOfTabBarVC((kTabBar_gift_vc,kTabBar_gift_title,kTabBar_gift,kTabBar_gift_selected),
                                                                            (kTabBar_home_vc,kTabBar_home_title,kTabBar_home,kTabBar_home_selected),
                                                                            (kTabBar_category_vc,kTabBar_category_title,kTabBar_category,kTabBar_category_selected),
                                                                            (kTabBar_me_vc,kTabBar_me_title,kTabBar_me,kTabBar_me_selected)
        )
        // 添加子控制器
        self.addChildViewControllerForTabBarVC(childData.vcNames, titles: childData.titles, imageNames: childData.imageNames, selectedImageNames: childData.selectedImageNames, tabBarVC: self)
        
        
    }
    
    

}

// MARK: - 【扩展】实现协议 UITabBarControllerDelegate
extension MainTabBarViewController :UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.title = self.tabBarItem.title
        return true
    }
}







