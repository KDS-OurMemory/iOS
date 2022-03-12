//
//  BaseScrollView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/08.
//

import UIKit

class BaseScrollView: UIScrollView {

    var lastSubViewYPosition:CGFloat = 0
    var lastSubViewXPosition:CGFloat = 0
    
    func addVerScrollSubView(subView:UIView,viewSize:CGSize ,verPadding:CGFloat) {
        self.addSubview(subView)
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
        subView.frame = CGRect(x: 0, y: lastSubViewYPosition + verPadding, width: viewSize.width, height: viewSize.height)
        
        self.contentSize = CGSize(width: mainWidth, height: self.contentSize.height + viewSize.height + verPadding)
        lastSubViewYPosition = subView.frame.maxY
    }
    
    func addHorScrollSubView(subView:UIView,viewSize:CGSize ,horPadding:CGFloat) {
        self.addSubview(subView)
        self.alwaysBounceHorizontal = true
        self.alwaysBounceVertical = false
        subView.frame = CGRect(x: lastSubViewXPosition + horPadding, y: 0, width: viewSize.width, height: viewSize.height)
        
        self.contentSize = CGSize(width: self.contentSize.width + horPadding , height: viewSize.height)
        lastSubViewXPosition = lastSubViewXPosition + horPadding
    }
    
    func resetSubViews() {
        lastSubViewYPosition = 0
        lastSubViewXPosition = 0
        self.contentSize = CGSize.zero
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }

}
