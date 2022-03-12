//
//  SelectView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/28.
//

import UIKit

class SelectView: BaseView {

    let selectBtn:UIButton = UIButton()
    
    override func prepareViews() {
        let horPadding = 15.0
        let viewHeight = 60.0
        
        self.frame = CGRect(x: 0, y: 0, width: mainWidth, height: viewHeight)
        self.addSubview(self.selectBtn)
        
        selectBtn.frame.size = self.frame.size
        selectBtn.contentMode = .left
        selectBtn.titleEdgeInsets = .init(top: 0, left: horPadding, bottom: 0, right: 0)
        
        
    }
    
    func selectBlock(block:@escaping () -> Void) {
        selectBtn.addAction { p1 in
            block()
        }
    }
    
    func setTitleWithImg(title:String, img:UIImage?) {
        let horPadding = 15.0
        let viewWidth = mainWidth - horPadding*2
        
        selectBtn.setTitle(title, for: .normal)
        selectBtn.setImage(img, for: .normal)
        selectBtn.contentEdgeInsets = .init(top: 0, left: viewWidth-(selectBtn.imageView?.image?.size.width)!, bottom: 0, right: 0)
    }

}
