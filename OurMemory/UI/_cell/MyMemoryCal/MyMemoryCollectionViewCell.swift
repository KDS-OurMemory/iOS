//
//  MyMemoryCollectionViewCell.swift
//  OurMemory
//
//  Created by 이승기 on 2022/03/01.
//

import UIKit

class MyMemoryCollectionViewCell: BaseCollectionViewCell {
    
    let todayTag = 100
    let dateNumLbl: UILabel = UILabel()
    let dateViews:[UIView] = []
    let dateBtn:UIButton = UIButton()
    let scheduleDotView:UIView = UIView()
    let scheduleListView:UIView = UIView()
    
    func setOnOffBlock(block:@escaping (Bool) -> Void) {
        dateBtn.addAction { p1 in
            self.setSelectedBackground()
            block(self.dateBtn.isSelected)
        }
    }
    
    func setData(data:CalSelectDateDataBinder,opecity:CGFloat) {
        
        let circleWidth = self.frame.width*0.2
        let circleHeight = 20
        let scheduleLblHeight = self.scheduleListView.frame.height*0.2
        
        self.addSubview(dateNumLbl)
        self.addSubview(dateBtn)
        self.addSubview(scheduleDotView)
        self.addSubview(scheduleListView)
        
        self.dateNumLbl.font = .systemFont(ofSize: 10)
        self.dateNumLbl.frame = CGRect(x:self.center.x-25,y:0,width: 50, height: 50)
        self.dateNumLbl.textAlignment = .center
        self.dateBtn.frame.size = self.frame.size
        self.scheduleDotView.frame = CGRect(x: 0, y: 40, width: self.frame.width, height: 20)
        self.scheduleListView.translatesAutoresizingMaskIntoConstraints = false
        self.scheduleListView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        self.scheduleListView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.scheduleListView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.scheduleListView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.dateNumLbl.clipsToBounds = true
        self.dateNumLbl.layer.cornerRadius = dateNumLbl.frame.width/2
        self.dateNumLbl.layer.masksToBounds = true
        self.dateNumLbl.text = data.getDateNum()
        self.dateBtn.isSelected = data.getIsSelcted()
        scheduleDotView.alpha = opecity
        scheduleListView.alpha = 1 - opecity
        self.setSelectedBackground()
        switch data.getDateState() {
        case .prev:
            self.dateNumLbl.textColor = .lightGray
            break
        case .current:
            self.dateNumLbl.textColor = .gray
            break
        case .next:
            self.dateNumLbl.textColor = .lightGray
            break
        case .today:
            self.dateNumLbl.textColor = .gray
            self.dateNumLbl.backgroundColor = .lightGray
            break
        default:
            break
        }
        
        
        if let scheduleData = data.getSchedule() {
            for schedule in scheduleData {
                let dotCnt = scheduleDotView.subviews.count
                let circleView:UIView = UIView(frame: CGRect(x: Int(circleWidth)*dotCnt, y: 0, width: Int(circleWidth), height: circleHeight))
                circleView.backgroundColor = .red
                circleView.layer.cornerRadius = circleWidth/2
                self.scheduleDotView.addSubview(circleView)
                
                let listCnt = scheduleListView.subviews.count
                let scheduleLbl = UILabel(frame: CGRect(x: 0, y: scheduleLblHeight*CGFloat(listCnt), width: self.scheduleListView.frame.width, height: scheduleLblHeight))
                scheduleLbl.font = .systemFont(ofSize: 5)
                if let color = schedule.getScheduleColor() {
                    scheduleLbl.layer.backgroundColor = color.cgColor
                }
                self.scheduleListView.addSubview(scheduleLbl)
            }
        }
    }
    
    fileprivate func setSelectedBackground() {
        self.dateNumLbl.backgroundColor = (self.dateBtn.isSelected ? UIColor.cyan:UIColor.clear)
    }
}
