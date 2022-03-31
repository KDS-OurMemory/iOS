//
//  MyMemoryScheduleView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/03/03.
//

import UIKit

class MyMemoryScheduleView: BaseView {

    let circleView = UIView()
    let titleLbl = UILabel()
    let scheduleLbl = UILabel()
    let scheduleViewBtn = UIButton()
    
    override func prepareViews() {
        let viewHeight = 50.0
        let viewContentsHeight = viewHeight*0.5
        let padding = 10.0
        self.frame = CGRect(x: 0, y: 0, width: mainWidth, height: viewHeight)
        
        self.addSubview(circleView)
        self.addSubview(titleLbl)
        self.addSubview(scheduleLbl)
        self.addSubview(scheduleViewBtn)
        
        scheduleViewBtn.frame = self.frame
        circleView.frame = CGRect(x: 0, y: 0, width: viewContentsHeight, height: viewContentsHeight)
        titleLbl.frame = CGRect(x: circleView.frame.maxX + padding, y: 0, width: mainWidth-padding-viewContentsHeight, height: viewContentsHeight)
        scheduleLbl.frame = CGRect(x: circleView.frame.maxX + padding, y: titleLbl.frame.maxY, width: titleLbl.frame.width, height: viewContentsHeight)
        
        circleView.layer.cornerRadius = circleView.frame.width/2
        titleLbl.textColor = .black
        scheduleLbl.textColor = .black
    }
    
    func setClickBLock(block:@escaping (BaseView) -> Void) {
        scheduleViewBtn.addAction { p1 in
            block(self)
        }
    }
    
    func setData(data:ScheduleDateDataBinder) {
        if let color = data.getScheduleColor() {
            circleView.backgroundColor = color
        }
        
        titleLbl.text = data.getName()
        scheduleLbl.text = data.getDateSchedule()
        
    }
    
}
