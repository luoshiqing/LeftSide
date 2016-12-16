//
//  NetWork.swift
//  Side
//
//  Created by sqluo on 2016/12/12.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class NetWork: NSObject {

    //自定义返回按钮
    class func creatBackBtn(target: Any?,selector: Selector,for controlEvents: UIControlEvents) ->(UIBarButtonItem,UIBarButtonItem){
        
        let leftBtn = UIButton(frame: CGRect(x: 0,y: 0,width: 13,height: 26))
        leftBtn.setImage(UIImage(named: "tmBack"), for: UIControlState())
        
        leftBtn.addTarget(target, action: selector, for: controlEvents)
        
        let backItem = UIBarButtonItem(customView: leftBtn)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spacer.width = -5
        
        return (spacer,backItem)
        
    }
    
    
}
