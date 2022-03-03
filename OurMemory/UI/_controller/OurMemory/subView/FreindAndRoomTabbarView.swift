//
//  FreindAndRoomTabbarView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/12.
//

import UIKit

enum SELECTTAB_FREINDANDROOM {
    case SELECT_FREINDTAB
    case SELECT_ROOMTAB
}

class FreindAndRoomTabbarView: BaseView {

    let freindBtn:UIButton = UIButton()
    let freindLineView:UIView = UIView()
    let roomBtn:UIButton = UIButton()
    let roomLineView:UIView = UIView()
    var selectTabBlock:((SELECTTAB_FREINDANDROOM) -> Void)?
    
    override func prepareViews() {
        let horPadding = 15.0
        let viewLineHieght = 1.0
        let btnWidth = mainWidth*0.5
        
        freindLineView.frame = CGRect(x: horPadding, y: topViewHeight - viewLineHieght, width: btnWidth - horPadding * 2, height: viewLineHieght)
        freindLineView.backgroundColor = .blue
        freindBtn.setTitleColor(.blue, for: .selected)
        freindBtn.setTitleColor(.black, for: .normal)
        freindBtn.isSelected = true
        
        self.addSubview(freindBtn)
        freindBtn.addSubview(freindLineView)
        freindBtn.translatesAutoresizingMaskIntoConstraints = false
        freindBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        freindBtn.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        freindBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        freindBtn.trailingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        freindBtn.setTitle("친구 목록", for: .normal)
        freindBtn.addAction { p1 in
            self.actionFreindTab(sender: p1 as! UIButton)
        }
        
        roomLineView.frame = CGRect(x: horPadding, y: topViewHeight - viewLineHieght, width: btnWidth - horPadding * 2, height: viewLineHieght)
        roomLineView.backgroundColor = .blue
        roomLineView.isHidden = true
        roomBtn.setTitleColor(.blue, for: .selected)
        roomBtn.setTitleColor(.black, for: .normal)
        self.addSubview(roomBtn)
        roomBtn.addSubview(roomLineView)
        roomBtn.translatesAutoresizingMaskIntoConstraints = false
        roomBtn.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        roomBtn.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        roomBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        roomBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        roomBtn.setTitle("방 목록", for: .normal)
        roomBtn.addAction { p1 in
            self.actionRoomTab(sender: p1 as! UIButton)
        }
    }
    
    func setSelectTabBlock(block:@escaping (SELECTTAB_FREINDANDROOM)->Void) {
        selectTabBlock = block
        if let block = selectTabBlock {
            block(.SELECT_FREINDTAB)
        }
    }
    
    fileprivate func actionFreindTab(sender:UIButton) {
        
        roomLineView.isHidden = true
        roomBtn.isSelected = false
        if let block = self.selectTabBlock {
            block(.SELECT_FREINDTAB)
        }
        freindBtn.isSelected = true
        freindLineView.isHidden = false
    }
    
    fileprivate func actionRoomTab(sender:UIButton) {
        
        freindLineView.isHidden = true
        freindBtn.isSelected = false
        if let block = self.selectTabBlock {
            block(.SELECT_ROOMTAB)
        }
        roomBtn.isSelected = true
        roomLineView.isHidden = false
    }

}
