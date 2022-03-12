//
//  AddScheduleItemView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/09.
//

import UIKit

enum scheduleItemCase {
    case itemDate
    case itemContent
    case itemLocation
}

class AddScheduleItemView: BaseView {

    let itemBtn:UIButton = UIButton()
    let mainWidth = UIScreen.main.bounds.width
    var itemView:BaseView = BaseView()
    
    override func prepareViews() {
        let iconBtnHeight:CGFloat = 40
        itemBtn.frame = CGRect(x: 0, y: 0, width:  mainWidth, height: iconBtnHeight)
        self.addSubview(itemBtn)
        itemBtn.setTitleColor(.black, for: .normal)
        itemBtn.contentMode = .left
        lastSubViewYPosition = iconBtnHeight
    }
    
    func setClickBtnBlock(block:@escaping ()->Void) {
        itemBtn.addAction { p1 in
            block()
        }
        
    }
    
    func setTitle(title:String) {
        itemBtn.setTitle(title, for: .normal)
    }
    
    func setTitleWithColor(title:String,titleColor:UIColor) {
        itemBtn.setTitle(title, for: .normal)
        itemBtn.setTitleColor(titleColor, for: .normal)
    }
    
    func setIconWithTitle(iconImg:UIImage, title:String, titleColor:UIColor) {
        itemBtn.setImage(iconImg, for: .normal)
        itemBtn.setTitle(title, for: .normal)
        itemBtn.setTitleColor(titleColor, for: .normal)
    }
    
    func setItem(item:scheduleItemCase, contents:ScheduleDataBinder) {
        
        let itemHeight:CGFloat = 30
        if self.subviews.contains(itemView) {
            self.resetSubViews()
            let iconBtnHeight:CGFloat = 40
            itemBtn.frame = CGRect(x: 0, y: 0, width:  mainWidth, height: iconBtnHeight)
            self.addSubview(itemBtn)
            self.frame.size = CGSize(width: mainWidth, height: self.frame.height + iconBtnHeight)
            lastSubViewYPosition = iconBtnHeight
        }
        itemView.resetSubViews()
        switch item {
        case .itemDate:
            for content in contents.getDates() {
                let dateLbl = UILabel()
                if let year = content.getYear(),let month = content.getMonth(), let day = content.getDay(), let our = content.getOur(), let min = content.getMin(), let weekDay = content.getWeekDay() {
                dateLbl.text = year+"년 "+month+"월 "+day+"일 "+"\(weekDay)요일 " + "\(our):\(min)"
                
                }
                itemView.addVerSubView(subView: dateLbl, viewHeight: itemHeight, verPadding: 0)
                dateLbl.textAlignment = .center
            }
            break
        case .itemContent:
            for content in contents.getContents() {
                let contentLbl = UILabel()
                contentLbl.text = content
                itemView.addVerSubView(subView: contentLbl, viewHeight: itemHeight, verPadding: 0)
                contentLbl.textAlignment = .center
            }
            break
        case .itemLocation:
            for content in contents.getLocations() {
                let locationLbl = UILabel()
                locationLbl.text = content
                itemView.addVerSubView(subView: locationLbl, viewHeight: itemHeight, verPadding: 0)
                locationLbl.textAlignment = .center
            }
            break
        }
        let lineView:UIView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: itemView.frame.height-2), size: CGSize(width: itemView.frame.width, height: 2)))
        itemView.addSubview(lineView)
        lineView.backgroundColor = .gray
        lineView.isHidden = itemView.subviews.count < 0
         
        self.addVerSubView(subView: itemView, viewHeight: itemView.frame.height, verPadding: 0)
    }
    
}
