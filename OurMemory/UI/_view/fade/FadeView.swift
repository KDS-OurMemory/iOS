//
//  FadeView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/10.
//

import UIKit

class FadeView: BaseView {

    let msgLbl = UILabel()
    
    override func prepareViews() {

        
        let msgViewWidth = mainWidth*0.6
        let tabViewHeight = 70.0
        let msgViewHeight = 40.0
        
        self.center.x = super.center.x
        self.frame.origin.y = mainHeight - tabViewHeight
        self.frame.size = CGSize(width: msgViewWidth, height: msgViewHeight)
        
        self.addSubview(msgLbl)
        msgLbl.frame.size = self.frame.size
        msgLbl.frame.origin = CGPoint.zero
        
        self.backgroundColor = UIColor(named: "blackWithAlpha80")
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.clear.cgColor
        
        msgLbl.textColor = .white
        msgLbl.textAlignment = .center
        
        self.alpha = 0.0
        
    }
    
    func setMsg(msg:String) {
        msgLbl.text = msg
    }
    
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
    
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0.0
            self.removeFromSuperview()
        }
    }
}
