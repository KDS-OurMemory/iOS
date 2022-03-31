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
    var indexPath:IndexPath?
    
    
    func setOnOffBlock(block:@escaping (Bool,UICollectionViewCell) -> Void) {
        dateBtn.addAction { p1 in
            self.setSelectedBackground()
            block(self.dateBtn.isSelected,self)
        }
    }
    
    func setData(data:CalSelectDateDataBinder,opecity:CGFloat) {
        
        let circleWidth:CGFloat = 4
        let circleHeight:CGFloat = 4
        let scheduleLblHeight = self.scheduleListView.frame.height*0.2
        
        self.addSubview(dateNumLbl)
        self.addSubview(dateBtn)
        self.addSubview(scheduleDotView)
        self.addSubview(scheduleListView)
        
        self.dateNumLbl.font = .systemFont(ofSize: 8)
        self.dateNumLbl.frame = CGRect(x:self.frame.width*0.35,y:0,width: 17, height: 15)
        self.dateNumLbl.textAlignment = .center
        self.dateBtn.frame.size = self.frame.size
        self.scheduleDotView.translatesAutoresizingMaskIntoConstraints = false
        self.scheduleDotView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.scheduleDotView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.scheduleDotView.heightAnchor.constraint(equalToConstant: circleHeight).isActive = true
        self.scheduleDotView.widthAnchor.constraint(equalToConstant: circleWidth).isActive = true
        
        self.scheduleListView.translatesAutoresizingMaskIntoConstraints = false
        self.scheduleListView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.scheduleListView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.scheduleListView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.scheduleListView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.dateNumLbl.clipsToBounds = true
        self.dateNumLbl.layer.cornerRadius = dateNumLbl.frame.height/2
        self.dateNumLbl.layer.masksToBounds = true
        self.dateNumLbl.text = data.getDateNum()
        self.dateBtn.isSelected = data.getIsSelcted()
        scheduleDotView.alpha = (opecity <= 0.122 ? 0:opecity) 
        scheduleListView.alpha = 1-opecity
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
            self.dateNumLbl.backgroundColor = (self.dateBtn.isSelected ? .cyan:.lightGray)
            break
        default:
            break
        }
        
        
        if let scheduleData = data.getSchedule() {
            for sv in self.scheduleDotView.subviews {
                sv.removeFromSuperview()
            }
            for sv in self.scheduleListView.subviews {
                sv.removeFromSuperview()
            }
            for schedule in scheduleData {
                let circleView:UIView = UIView()
                circleView.backgroundColor = .red
                circleView.layer.cornerRadius = circleWidth/2
                self.scheduleDotView.addSubview(circleView)
                let index = scheduleDotView.subviews.firstIndex(of: circleView)!
                circleView.translatesAutoresizingMaskIntoConstraints = false
                if index == 0 {
                    circleView.leadingAnchor.constraint(equalTo: self.scheduleDotView.leadingAnchor, constant: 0).isActive = true
                }else {
                    circleView.leadingAnchor.constraint(equalTo: self.scheduleDotView.subviews[index-1].trailingAnchor, constant: circleWidth).isActive = true
                }
                circleView.centerYAnchor.constraint(equalTo: self.scheduleDotView.centerYAnchor).isActive = true
                circleView.widthAnchor.constraint(equalToConstant: circleWidth).isActive = true
                circleView.heightAnchor.constraint(equalToConstant: circleHeight).isActive = true
                
                self.scheduleDotView.constraints.first(where: {
                    $0.firstAttribute == .width
                })?.constant = CGFloat(index)*(circleWidth*2)
                
                self.scheduleDotView.setNeedsUpdateConstraints()
                self.scheduleDotView.layoutIfNeeded()
                
                let listCnt = scheduleListView.subviews.count
                let scheduleLbl = UILabel(frame: CGRect(x: 0, y: scheduleLblHeight*CGFloat(listCnt), width: self.scheduleListView.frame.width, height: scheduleLblHeight))
                scheduleLbl.text = schedule.getName()
                scheduleLbl.textAlignment = .center
                scheduleLbl.font = .systemFont(ofSize: 10)
                if let color = schedule.getScheduleColor() {
                    scheduleLbl.backgroundColor = color
                }
                self.scheduleListView.addSubview(scheduleLbl)
            }
        }
    }
    
    fileprivate func setSelectedBackground() {
        self.dateNumLbl.backgroundColor = (self.dateBtn.isSelected ? UIColor.cyan:UIColor.clear)
    }
}
