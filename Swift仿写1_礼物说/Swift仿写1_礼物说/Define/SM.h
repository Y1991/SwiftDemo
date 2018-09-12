//
//  SM.h
//  Swift仿写1_礼物说
//  SM --> 即 说明
//  Created by Guangquan Yu on 2017/9/4.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

#ifndef SM_h
#define SM_h

// 注释、（类层次的）结构
//*********************************************************************
// MARK: - 【类】
// MARK: - 【扩展】点击事件
// MARK: - 【扩展】私有方法
    //MARK: 1. ------
    //--  (1) ------
// MARK: - 【扩展】实现协议 UITabBarControllerDelegate
// MARK: - 【扩展】外界赋值
    //外界赋值可以使用方法的形式，也可以使用属性的形式
    //value(typeString: String) -> ()  给内部存储属性赋值
// MARK: - 【声明】协议  ---
//*********************************************************************


// （类内部的）结构
//*********************************************************************
//self.makeUI()     使用 addSubviews 的方法
//self.makeFrame()  将模块的子View放到扩展中去实现， 参考 MerchandiseListTableViewCell
//self.loadData() //请求数据
//self.makeHandle()  其他处理
//*********************************************************************


//创建表视图   参考 MerchandiseListViewController
//创建九宫格   参考 HotViewController
//创建Model   参考 YUCycleModel
#endif /* SM_h */
