//
//  CalPopCollectionViewCell.swift
//  OurMemory
//
//  Created by 이승기 on 2022/03/18.
//

import UIKit

class CalPopCollectionViewCell: BaseCollectionViewCell {

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
    
    func setData(day:String, isSelected:Bool) {
    
        self.addSubview(dateNumLbl)
        self.addSubview(dateBtn)
        
        self.dateNumLbl.font = .systemFont(ofSize: 8)
        self.dateNumLbl.frame = CGRect(x:self.frame.width*0.35,y:0,width: 17, height: 15)
        self.dateNumLbl.textAlignment = .center
        self.dateBtn.frame.size = self.frame.size
        self.dateNumLbl.clipsToBounds = true
        self.dateNumLbl.layer.cornerRadius = dateNumLbl.frame.height/2
        self.dateNumLbl.layer.masksToBounds = true
        self.dateNumLbl.text = day
        self.dateBtn.isSelected = isSelected
        
        self.setSelectedBackground()
    }

    fileprivate func setSelectedBackground() {
        self.dateNumLbl.backgroundColor = (self.dateBtn.isSelected ? UIColor.cyan:UIColor.clear)
    }
}
