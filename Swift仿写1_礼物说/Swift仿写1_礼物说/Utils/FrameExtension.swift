
//
//  FrameExtension.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/1.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import Foundation
import UIKit



extension UIView{

    var x:CGFloat {  // 计算属性
        get{
            return self.frame.origin.x
        }set{
            var temp:CGRect = self.frame;
            temp.origin.x = CGFloat(newValue)
            self.frame = temp;
        }
    }
    
    var y:CGFloat {  // 计算属性
        get{
            return CGFloat(self.frame.origin.y)
        }set{
            var temp:CGRect = self.frame;
            temp.origin.y = CGFloat(newValue)
            self.frame = temp;
        }
    }
    
    var width:CGFloat {  // 计算属性
        get{
            return self.frame.size.width
        }set{
            var temp:CGRect = self.frame;
            temp.size.width = CGFloat(newValue)
            self.frame = temp;
        }
    }
    
    var height:CGFloat {  // 计算属性
        get{
            return self.frame.size.height
        }set{
            var temp:CGRect = self.frame;
            temp.size.height = CGFloat(newValue)
            self.frame = temp;
        }
    }
    
    
    var origin:CGPoint {  // 计算属性
        get{
            return self.frame.origin
        }set{
            var temp:CGRect = self.frame
            temp.origin = newValue
            self.frame = temp
        }
    }
    var size:CGSize {  // 计算属性
        get{
            return self.frame.size
        }set{
            var temp:CGRect = self.frame
            temp.size = newValue
            self.frame = temp
        }
    }
    
    var centerX:CGFloat {  // 计算属性
        get{
            return self.x+self.width/2.0
        }set{
            var temp:CGRect = self.frame;
            temp.origin.x = CGFloat(newValue-self.width/2.0)
            self.frame = temp;
        }
    }
    
    var centerY:CGFloat {  // 计算属性
        get{
            return self.y+self.height/2.0
        }set{
            var temp:CGRect = self.frame;
            temp.origin.y = newValue-self.height/2.0
            self.frame = temp;
        }
    }
    
    
    var maxX:CGFloat {  // 计算属性
        get{
            return self.x+self.width
        }
    }
    
    var maxY:CGFloat {  // 计算属性
        get{
            return self.y+self.height
        }
    }
    
    ///计算的是子视图底部 距离 父视图底部的 距离
    var bottomFromSuperView:CGFloat {  // 计算属性
        get{
            return (self.superview?.height)! - self.y - self.height
        }
    }
    
    

}
