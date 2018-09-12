//
//  TabBarGlobalVariable.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/8/31.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//
//【规则】【以后自己声明的小k打头的就是 静态变量或者宏定义】
import Foundation
import UIKit

//【例子】
//---------------------------------------{
/**
 *   替代oc中的#define,列举一些常用宏
 */

// 屏幕的物理宽度
let kScreenWidth = UIScreen.main.bounds.size.width
//public let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let kScreenBounds: CGRect = UIScreen.main.bounds


/*【亲测】下面声明的是静态变量*/
let kData:NSString   = "data";
//---------------------------------------}


let kTabBar_gift_selected:NSString = "tabbar_gift_selected"
let kTabBar_home_selected:NSString = "tabbar_home_selected"
let kTabBar_category_selected:NSString = "tabbar_category_selected"
let kTabBar_me_selected:NSString = "tabbar_me_selected"

let kTabBar_gift:NSString = "tabbar_gift"
let kTabBar_home:NSString = "tabbar_home"
let kTabBar_category:NSString = "tabbar_category"
let kTabBar_me:NSString = "tabbar_me"

let kTabBar_gift_title:NSString = "礼物说"
let kTabBar_home_title:NSString = "热门"
let kTabBar_category_title:NSString = "分类"
let kTabBar_me_title:NSString = "我"

let kTabBar_gift_vc:NSString = "GiftViewController"
let kTabBar_home_vc:NSString = "HotViewController"
let kTabBar_category_vc:NSString = "ClassificationViewController"
let kTabBar_me_vc:NSString = "MeViewController"








