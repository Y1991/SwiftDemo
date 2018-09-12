//
//  NSObjectExtension.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/8/31.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import Foundation
import UIKit

extension NSObject{
    
    //MARK: 获取targetName
    static var targetName:String {
        let infoDictionary = Bundle.main.infoDictionary
        return (infoDictionary?["CFBundleName"] as? String)!
    }
    
    //MARK: 获取类对象【这是类方法】
    /// 获取类对象【这是类方法】
    ///
    /// - Parameter className: 类名
    /// - Returns: 返回类对象
    static func getClassObject(_ className: NSString) -> UIViewController? {
        
        let targetName = NSObject.targetName
        guard let Class = NSClassFromString(targetName+"."+(className as String)) as?UIViewController.Type else {
            print("没有获取到某个类的类型")
            return nil;
        }
        
        let vc: UIViewController = Class.init()
        return vc;
    }
    
    //MARK: 比较版本号
    /// 比较版本号
    ///
    /// - Parameters:
    ///   - one: 第一个
    ///   - two: 第二个
    /// - Returns: true 表示第一个版本号大于等于第二个版本号
    static func compareVersion(_ one:String, two:String) -> Bool{
        let oneArray:[String] = one.components(separatedBy: ".")
        let twoArray:[String] = two.components(separatedBy: ".")
        
        let oneCount = oneArray.count
        let twoCount = twoArray.count
        let minCount = oneCount >= twoCount ? twoCount:oneCount
        
        
        for i in 0...minCount {
            
            let oneInt: Int = Int(oneArray[i])!
            let twoInt: Int = Int(twoArray[i])!
            
            guard oneInt == twoInt else {
                print("不相等")
                guard oneInt > twoInt else {
                    print("小于")
                    return false;
                }
                
                return true
            }
  
        }
        
        guard oneCount>=twoCount else {
            print("two的数量大")
            let differenceCount:Int = twoCount - oneCount
            for i in 0...differenceCount {
                
                let c:Int = Int(twoArray[twoCount-i])!
                if (c > 0)  {
                    return false
                }
                
            }
            return true
        }
        return true
        
    }
    //MARK: 获取单色图片
    static func getImage(_ color:UIColor) -> UIImage{
        let rect:CGRect = CGRect.init(x: 0, y: 0, width: 1.0, height: 1.0);
        UIGraphicsBeginImageContext(rect.size);
        let context:CGContext = UIGraphicsGetCurrentContext()!;
        
        context.setFillColor(color.cgColor);
        context.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image!;
    
    }
    
    //MARK: 计算字符串长度
    static func sizeWithText(text: NSString, font: UIFont, size: CGSize) -> CGSize {
        let attributes = [NSFontAttributeName: font]
        let option = (NSStringDrawingOptions.usesLineFragmentOrigin)
        //        |(NSStringDrawingOptions.usesFontLeading)
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size;
    }
    
    //MARK: 随机颜色
    static func randomColor() -> UIColor {
        
        return UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1);
    }
    
    
    //MARK: 【数据处理】传入多个元组，返回一个元组
    /*传入多个元组，返回一个元组
        handleDataForChildViewControllerOfTabBarVC  可以模仿此方法
     */
    

}
