//
//  ViewControllerExtension.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/4.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import Foundation
import UIKit

// MARK: -  ViewController
extension NSObject{
    //MARK: 1.修复导航条引起的异常
    
    /// 修复导航条引起的异常
    ///
    /// - Parameter vc: 控制器
    static func repairNavigationBar(_ vc: UIViewController) {
        
        // 修复导航条引起的异常布局
        vc.automaticallyAdjustsScrollViewInsets = true
        if NSObject.compareVersion(UIDevice.current.systemVersion, two: "7.0.0") {
            vc.edgesForExtendedLayout = UIRectEdge()
        }
    }
}

// MARK: - NavigationController
extension NSObject{
    //MARK: 1.设置导航条的显示
    /// 设置导航条的显示
    static func makeNavigationBar() -> () {
       
        let appearance = UINavigationBar.appearance()
        appearance.isTranslucent = false
        appearance.setBackgroundImage(NSObject.getImage(UIColor.red), for: UIBarMetrics.default)
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.white
        textAttrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 29)
        appearance.titleTextAttributes = textAttrs
        
        //        self.title = self.tabBarItem.title
    }

}


// MARK: - Window
extension NSObject{
    //MARK: 1.设置Window
    /// 设置Window
    static func makeWindow(_ rootVC:UIViewController?) -> (UIWindow) {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        //        self.window?.rootViewController = UINavigationController.init(rootViewController: vc)
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        return window
    }

}


// MARK: - TabBarController
extension NSObject{
    //MARK: 1.将控制器添加为子控制器
    /// 【tabBar】将控制器添加为子控制器
    ///
    /// - Parameters:
    ///   - childControllerNames: 子控制器名
    ///   - titles: 控制器对应的item名
    ///   - imageNames: 控制器对应的图片名
    ///   - selectedImageNames: 控制器对应的选中图片名
    func addChildViewControllerForTabBarVC(_ childControllerNames: [NSString], titles: [NSString] ,imageNames: [NSString], selectedImageNames: [NSString], tabBarVC: UITabBarController) {
        
        let viewControllers: NSMutableArray = NSMutableArray(capacity: childControllerNames.count)
        
        for i in 0..<childControllerNames.count {
            let vc:UIViewController = NSObject.getClassObject(childControllerNames[i])!
            vc.tabBarItem  = UITabBarItem.init(title: titles[i] as String, image: UIImage.init(named: imageNames[i] as String) , selectedImage: UIImage.init(named: selectedImageNames[i] as String))
            let nav = YUBaseNavigationController(rootViewController: vc)
            
            viewControllers.add(nav)
        }
        
        
        tabBarVC.viewControllers = viewControllers as? [UIViewController];
    }
    
    //MARk: 2.处理数据，将分开的数据，合并 （传入多个元组，返回一个元组）
    /// 【tabBar】处理数据，将分开的数据，合并 （传入多个元组，返回一个元组）
    ///
    /// - Parameter tupleSet: 0是子控制器名字，1是title，2是图片名，3是选中时的图片名
    /// - Returns: 元组（元素是数组）
    static func handleDataForChildViewControllerOfTabBarVC(_ tupleSet:(NSString, NSString, NSString, NSString)...) -> (vcNames:[NSString], titles:[NSString], imageNames:[NSString], selectedImageNames:[NSString]) {
        let vcNames:NSMutableArray = NSMutableArray()
        let titles:NSMutableArray = NSMutableArray()
        let imageNames:NSMutableArray = NSMutableArray()
        let selectedImageNames:NSMutableArray = NSMutableArray()
        
        
        for tuple in tupleSet{
            vcNames.add(tuple.0)
            titles.add(tuple.1)
            imageNames.add(tuple.2)
            selectedImageNames.add(tuple.3)
        }
        
        return (vcNames as! [NSString], titles as! [NSString], imageNames as! [NSString], selectedImageNames as! [NSString])
    }
    
    
    //MARk: 3.设置TabBarItem的显示
    /// 设置TabBarItem的显示
    ///
    /// - Parameters:
    ///   - normalSet: 正常时的显示设置
    ///   - selectedSet: 选中时的设置
    static func makeTabBarItemAppearance(_ normalSet: (UIColor, UIFont), selectedSet: (UIColor, UIFont), tabBarVC: UITabBarController) -> () {
        
        tabBarVC.selectedIndex = 0
        
        tabBarVC.tabBar.tintColor = UIColor.white
        // 条的背景颜色
        tabBarVC.tabBar.barTintColor = UIColor(white: 0.988, alpha: 1)
        
        // 去掉TabBar上边的线----【未测】
        tabBarVC.tabBar.isTranslucent = false
        tabBarVC.tabBar.shadowImage = NSObject.getImage(UIColor.red)
        tabBarVC.tabBar.backgroundImage = UIImage.init()
        
        // 设置显示（字体颜色和字号）
        // 普通状态
        let attri:NSDictionary = NSDictionary.init(dictionary: [NSForegroundColorAttributeName: normalSet.0, NSFontAttributeName: normalSet.1])
        UITabBarItem.appearance().setTitleTextAttributes(attri as? [String : Any], for: .normal)
        // 选中状态
        let selectedAttri:NSDictionary = NSDictionary.init(dictionary: [NSForegroundColorAttributeName: selectedSet.0, NSFontAttributeName: selectedSet.1])
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttri as? [String : Any], for: .selected)
    }
}
