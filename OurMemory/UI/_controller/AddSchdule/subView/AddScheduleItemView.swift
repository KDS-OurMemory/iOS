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

    let iconBtn:UIButton = UIButton()
    let mainWidth = UIScreen.main.bounds.width
    var itemView:BaseView = BaseView()
    
    override func prepareViews() {
        let iconBtnHeight:CGFloat = 40
        iconBtn.frame = CGRect(x: 0, y: 0, width:  mainWidth, height: iconBtnHeight)
        self.addSubview(iconBtn)
        
        lastSubViewYPosition = iconBtnHeight
    }
    
    func setIconWithTitle(iconImg:UIImage, title:String, titleColor:UIColor) {
        iconBtn.setImage(iconImg, for: .normal)
        iconBtn.setTitle(title, for: .normal)
    }
    
    func setItem(item:scheduleItemCase, contents:[String]) {
        
        let itemHeight:CGFloat = 30
        if self.subviews.contains(itemView) {
            itemView.removeFromSuperview()
            itemView = BaseView()
        }
        
        switch item {
        case .itemDate:
            for content in contents {
                let dateLbl = UILabel()
                dateLbl.text = content
                itemView.addVerSubView(subView: dateLbl, viewHeight: itemHeight, verPadding: 0)
                dateLbl.textAlignment = .center
            }
            break
        case .itemContent:
            for content in contents {
                let contentLbl = UILabel()
                contentLbl.text = content
                itemView.addVerSubView(subView: contentLbl, viewHeight: itemHeight, verPadding: 0)
                contentLbl.textAlignment = .center
            }
            break
        case .itemLocation:
            for content in contents {
                let locationLbl = UILabel()
                locationLbl.text = content
                itemView.addVerSubView(subView: locationLbl, viewHeight: itemHeight, verPadding: 0)
                locationLbl.textAlignment = .center
            }
            break
        }
        let lineView:UIView = .init(frame: CGRect(origin: CGPoint(x: 0, y: itemView.frame.height-1), size: CGSize(width: itemView.frame.width, height: 1)))
        itemView.addSubview(lineView)
        lineView.backgroundColor = .gray
        lineView.isHidden = itemView.subviews.count > 0
         
        self.addVerSubView(subView: itemView, viewHeight: itemView.frame.height, verPadding: 0)
    }
    
}
