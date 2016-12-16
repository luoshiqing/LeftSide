//
//  SideViewController.swift
//  Side
//
//  Created by sqluo on 2016/11/17.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

//打开左侧窗时，中视图(右视图)露出的宽度
let pageDistance: CGFloat = 80

class SideViewController: UIViewController ,LeftViewControllerDelegate{
    
    //屏幕bounds
    fileprivate let screenBounds = UIScreen.main.bounds
    //滑动距离大于此数时，状态改变（ 关-->开，或者 开-->关）
    fileprivate var vCouldChangeDeckStateDistance: CGFloat!
    //主视图
    fileprivate var mainCtr: UIViewController!
    //左视图
    fileprivate var leftCtr: UIViewController!
    //平移位置
    fileprivate var netTranslation = CGPoint(x: 0, y: 0)
    //初始时侧滑窗关闭
    fileprivate var leftClosed = true
    //处理右边主控制器点击手势
    fileprivate var clickTap: UITapGestureRecognizer! //单击手势
    //tabbar
    fileprivate var tabBar: UITabBar?
    
    
    init(mainVC: UIViewController,leftCtr: UIViewController,tabBar: UITabBar?){
        super.init(nibName: nil, bundle: nil)

        self.leftCtr = leftCtr
        
        self.mainCtr = mainVC
        
        
        self.tabBar = tabBar
        //初始化偏移数
        self.vCouldChangeDeckStateDistance = (screenBounds.width - pageDistance) / 2 - 40
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "首页"
        self.view.backgroundColor = UIColor.white
        
        //1.设置左边视图
        let leftWidth = screenBounds.width - pageDistance
        // 总宽度为 leftWidth ，往左边偏移 一半
        (self.leftCtr as! LeftViewController).myTabView?.frame = CGRect(x: -(leftWidth / 2), y: 0, width: leftWidth, height: screenBounds.height)
        self.leftCtr.view.backgroundColor = UIColor.red
        self.view.addSubview(self.leftCtr.view)
        
        //2.设置主视图拖动手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handTap(send:)))
        self.mainCtr.view.addGestureRecognizer(pan)
        self.mainCtr.view.backgroundColor = UIColor.gray
        self.view.addSubview(self.mainCtr.view)
        
        //3.设置代理
        (self.leftCtr as! LeftViewController).delegate = self
        //传递导航控制器
        (self.mainCtr as! MainViewController).navgationCtr = self.navigationController
    }
    
    //拖动手势响应事件
    @objc fileprivate func handTap(send: UIPanGestureRecognizer){
        //获取到点
        let point = send.translation(in: self.view)
        //acx 为偏移量
        let acx = self.netTranslation.x + point.x
        var needMoveWithTap = true //是否还需要跟随手指移动
        //如果小于0 或者大于屏幕宽度减去露出的宽度
        if acx < 0 || acx > screenBounds.width - pageDistance {
            needMoveWithTap = false
        }
        
        if needMoveWithTap {
            //设置主要视图偏移
            self.mainCtr.view.frame = CGRect(x: acx, y: 0, width: self.mainCtr.view.frame.size.width, height: self.mainCtr.view.frame.size.height)
            //设置左视图偏移
            let leftWidth = screenBounds.width - pageDistance
            (self.leftCtr as! LeftViewController).myTabView?.frame = CGRect(x: acx / 2 - (leftWidth / 2), y: 0, width: leftWidth, height: screenBounds.height)
            //设置tabbar偏移
            self.proofreadTabBarX(acx)
            //设置导航栏偏移
            self.proofreadNavBarX(acx)
        }
        
        //手势结束后修正位置,超过约一半时向多出的一半偏移
        if send.state == UIGestureRecognizerState.ended {
            if acx <= 0 {
                //重置信息
                self.netTranslation.x = 0
                self.leftClosed = true
                //关闭
                self.closeLeftView()
            }else if self.netTranslation.x > screenBounds.width - pageDistance{
                //重置
                self.netTranslation.x = screenBounds.width - pageDistance
                self.leftClosed = false
                //开启
                self.openLeftView()
            }else{
                //累计
                self.netTranslation.x += point.x
                //判断开始的状态，
                if self.leftClosed { //如果是关闭的
                    if self.netTranslation.x > self.vCouldChangeDeckStateDistance {
                        self.openLeftView()
                    }else{
                        self.closeLeftView()
                    }
                }else{
                    let max = self.screenBounds.width - self.vCouldChangeDeckStateDistance
                    if self.netTranslation.x > max {
                        self.openLeftView()
                    }else{
                        self.closeLeftView()
                    }
                }
            }
        }
    }
    
    //设置tabbar 偏移量
    fileprivate func proofreadTabBarX(_ acx: CGFloat){
        if self.tabBar != nil {
            self.tabBar!.frame.origin.x = acx
        }
    }
    //设置导航栏 偏移量
    fileprivate func proofreadNavBarX(_ acx: CGFloat){
        
        if let navBar = self.navigationController?.navigationBar {
            navBar.frame.origin.x = acx
        }
    }
    
    
    //打开左侧
    func openLeftView(){
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            
            self.mainCtr.view.frame = CGRect(x: self.screenBounds.width - pageDistance, y: 0, width: self.mainCtr.view.frame.width, height: self.mainCtr.view.frame.height)

            
            let leftWidth = self.screenBounds.width - pageDistance
            (self.leftCtr as! LeftViewController).myTabView?.frame = CGRect(x: 0, y: 0, width: leftWidth, height: self.screenBounds.height)

            self.proofreadTabBarX(self.screenBounds.width - pageDistance)
            self.proofreadNavBarX(self.screenBounds.width - pageDistance)
            
        }) { (isOk) in
            //动画完成，重置信息
            self.leftClosed = false
            self.netTranslation.x = self.screenBounds.width - pageDistance
            //添加单击手势
            self.addClickTap()
        }
   
    }
    //关闭左侧
    func closeLeftView(){
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            
            self.mainCtr.view.frame = CGRect(x: 0, y: 0, width: self.mainCtr.view.frame.width, height: self.mainCtr.view.frame.height)
            
            let leftWidth = self.screenBounds.width - pageDistance
            (self.leftCtr as! LeftViewController).myTabView?.frame = CGRect(x: -(leftWidth / 2), y: 0, width: leftWidth, height: self.screenBounds.height)
            
            self.proofreadTabBarX(0)
            self.proofreadNavBarX(0)
            
        }) { (isOk) in
            //动画完成，重置信息
            self.leftClosed = true
            self.netTranslation.x = 0
            //移除单击手势
            self.removeClickTap()
        }
    }

    //添加一个单击手势
    fileprivate func addClickTap(){
        if self.clickTap == nil {
            self.clickTap = UITapGestureRecognizer(target: self, action: #selector(self.clickTapAct(send:)))
            self.mainCtr.view.addGestureRecognizer(self.clickTap)
        }
    }
    //删除 单击手势
    fileprivate func removeClickTap(){
        
        if self.clickTap != nil {
            self.mainCtr.view.removeGestureRecognizer(self.clickTap)
            self.clickTap = nil
        }
    }
    //单击的时候处理的事情
    @objc fileprivate func clickTapAct(send: UITapGestureRecognizer){
        //关闭左侧
        self.closeLeftView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //-------------Delegate--------------------//
    
    //MARK:Left代理
    func didSelectRowAt(indexPath: IndexPath ,name: String) {
        
        print(name)
        
        self.closeLeftView()
        
        let tmpVC = TmpViewController()
        tmpVC.navigationItem.title = name
        
        tmpVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(tmpVC, animated: true)
        
    }
    
    

}
