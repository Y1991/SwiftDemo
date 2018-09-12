//
//  YUCycleScrollView.swift
//  Swift仿写1_礼物说
//  [ 轮播图 ]
//  Created by Guangquan Yu on 2017/9/11.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit

class YUCycleModel: NSObject {
    //MARK: 1.system method
    override init() {
        super.init()
        
    }
    
    //MARK: 2.存储属性
    open var networkImageName: String?
    open var placeholderImageName: String?
    open var index: NSInteger = 0
    open var describe: String?
    
    fileprivate var width: Float = 0//宽
    fileprivate var height: Float = 0//高
    
    //MARK: 3.计算属性
    var getWidth : Float {
        return self.width;
    }
    var getHeight : Float {
        return self.height;
    }
    
    
    //MARK: 4.赋值方法
    func setValue(_ width: Float ,height: Float) -> () {
        
        self.width = width;
        self.height = height;
    }
    
}
//MARK:
class YUCycleScrollView: UIView {

    //MARK: 1.System method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeUI()
        self.makeFrame()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func create(_ frame: CGRect, data dataArray: [YUCycleModel]) -> YUCycleScrollView{
        
        let cycleScrollView: YUCycleScrollView = YUCycleScrollView.init(frame: frame)
        
        for model: YUCycleModel in dataArray {
            //补充宽高
            model.setValue(Float(frame.size.width), height: Float(frame.size.height))
            //处理数据
            if (model.networkImageName == nil) {
                model.networkImageName = "";
                model.describe = "没有图片";
            }
        }
        
        if (dataArray.count > 1) {
            let muDataArray: NSMutableArray = NSMutableArray(array: dataArray)
            
            muDataArray.add(addObject:dataArray[0])
            muDataArray.insert(dataArray[dataArray.count - 1], at: 0)
            cycleScrollView.value(dataArray: muDataArray as! [YUCycleModel])
        }else{
            cycleScrollView.value(dataArray: dataArray)
   
        }
        
//        NSLog("%f   %f", cycleScrollView.frame.size.width,cycleScrollView.frame.size.height)
        for i in 0..<(cycleScrollView.dataArray.count) {
            let subView: YUCycleView = YUCycleView(frame:CGRect.zero)
            cycleScrollView.scrollView.addSubviews([subView])
            subView.frame = CGRect(x: cycleScrollView.frame.size.width*CGFloat(i), y: 0, width: cycleScrollView.frame.size.width, height: cycleScrollView.frame.size.height)
            
            let model: YUCycleModel = cycleScrollView.dataArray[i]
            subView.value(model: model);
            cycleScrollView.scrollView.addSubview(subView)
        }
  
        
            cycleScrollView.scrollView.contentSize = CGSize.init(width: cycleScrollView.frame.size.width*CGFloat(cycleScrollView.dataArray.count), height: cycleScrollView.frame.size.height)
            cycleScrollView.scrollView.contentOffset = CGPoint(x: cycleScrollView.frame.size.width*1.0, y: 0)
            cycleScrollView.pageControl.numberOfPages = dataArray.count;
            cycleScrollView.makeCountdown()
        return cycleScrollView
    }

    //MARK: 2.UI
    fileprivate func makeUI() {
        self.addSubviews([self.scrollView, self.pageControl])
    }
    //MARK: 3.Frame
    fileprivate func makeFrame() {
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height);
    }
    
    fileprivate func makeCountdown() ->(){
//        // 无主引用
//        unowned let weakSelf:YUCycleScrollView = self;
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
//        self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
//            weakSelf.nextPage()
//        })
        RunLoop.main.add(self.timer!, forMode: .commonModes)
        self.timer?.fireDate = Date(timeIntervalSinceNow: 2)
        
    }

    @objc fileprivate func nextPage() ->(){
//        NSLog("   %f", self.frame.size.width)
        //image_page表示滚动视图上第几张图片 0开头
        var image_page:NSInteger = NSInteger(self.scrollView.contentOffset.x/self.frame.size.width)
        
        image_page += 1;
        
        self.scroll(ToPageIndex: image_page, animate: true)
        
    }

    fileprivate func scroll(ToPageIndex pageIndex:NSInteger, animate:Bool){
        //三种情况
        if pageIndex == self.dataArray.count-1 {//最后一张图片，则滚动为正数第二张
            let endPageIndex:NSInteger  = 1
            
            self.startScroll(pageIndex, scrollToSide: true, endPageIndex: endPageIndex, animate: animate)
          
        }else if pageIndex == 0 {//如果第一张，则滚动为倒数第二张
            
            let endPageIndex:NSInteger  = self.dataArray.count-2;
            
            self.startScroll(pageIndex, scrollToSide: true, endPageIndex: endPageIndex, animate: animate)
            
        }else if pageIndex>0&&pageIndex<self.dataArray.count-1 {
            self.startScroll(pageIndex, scrollToSide: false, endPageIndex: pageIndex, animate: animate)
       
        }
        
    }

    fileprivate func startScroll(_ pageIndex: NSInteger, scrollToSide isSide:Bool, endPageIndex:NSInteger, animate:Bool ) ->(){
        
        UIView.animate(withDuration: 1, animations: {
            self.pageControl.currentPage = endPageIndex-1;
            self.scrollView.contentOffset = CGPoint(x: self.frame.size.width*CGFloat(pageIndex), y: 0)//做一个向右滚动的效果
        }) { (finish) in
            if (isSide) {
                self.scrollView.contentOffset = CGPoint(x: self.frame.size.width*CGFloat(endPageIndex), y: 0)

            }
        }

    }
    
    
    //MARK: 3.存储属性
    fileprivate var timer: Timer?
    var dataArray: [YUCycleModel] = Array()


//    //MARK: 4.声明引用
//    weak open var delegate: YUHorizScrollViewDelegate?
//
//
    //MARK: 5.懒加载
//    // 懒加载 （1）数据源
//    fileprivate lazy var dataArray:[YUCycleModel] = {
//        let dataArray = Array<Any>()
//        return dataArray as! [YUCycleModel]
//    }()

    // 懒加载 （2）scrollView
     lazy var scrollView:UIScrollView = {
        let scrollView = NSObject.createScrollView(CGRect.init(x: 0, y: 0, width: self.width, height: self.height), delegate: self, pagingEnabled: true, bounces: false, showsHorizontalScrollIndicator: false, showsVerticalScrollIndicator: false)
      
        return scrollView
    }()
    // 懒加载 （3）pageControl
    fileprivate lazy var pageControl:UIPageControl = {
        let pageControl = NSObject.createPageControl(CGRect.init(x: self.frame.size.width/2.0-100/2.0, y: self.frame.size.height-10, width: 100, height: 8), bgColor: UIColor.clear, currentPageIndicatorTintColor: UIColor.yellow, pageIndicatorTintColor: UIColor.blue)
        
        return pageControl
    }()



}
// MARK: - 【扩展】外界赋值
extension YUCycleScrollView{
    func value(dataArray: [YUCycleModel]) -> () {
        self.dataArray = dataArray
    }
}
//MARK: - 【扩展】遵循代理 UIScrollViewDelegate
extension YUCycleScrollView: UIScrollViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            self.timer?.fireDate = Date.distantFuture//拖拽滚动视图时暂停计时器（开始在遥远的未来）
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.scrollView {
            self.timer?.fireDate = Date(timeIntervalSinceNow: 2)//定时器开始计时
        }
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.scrollView.isScrollEnabled = false
        NSLog("滑动开始减速");
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollView.isScrollEnabled = true
        NSLog("滑动停止减速");//停止减速的时候，scrollView一定停止滚动
        let image_page:NSInteger = NSInteger(floor(scrollView.contentOffset.x/self.frame.size.width));
        scrollView.contentOffset = CGPoint(x: self.frame.size.width*CGFloat(image_page), y: 0)
        
        self.scroll(ToPageIndex: image_page, animate: false)
    }

}
