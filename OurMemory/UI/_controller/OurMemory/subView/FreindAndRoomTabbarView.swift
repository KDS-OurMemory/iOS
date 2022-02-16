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
        let freindTabView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width*0.5, height: topViewHeight))
        freindTabView.addSubview(freindLineView)
        freindLineView.frame = CGRect(x: horPadding, y: topViewHeight - viewLineHieght, width: freindTabView.frame.width - horPadding * 2, height: viewLineHieght)
        freindLineView.backgroundColor = .blue
        freindBtn.setTitleColor(.blue, for: .selected)
        freindBtn.setTitleColor(.black, for: .normal)
        freindBtn.isSelected = true
        
        let roomTabView:UIView = UIView(frame: CGRect(x: self.frame.width, y: 0, width: self.frame.width*0.5, height: topViewHeight))
        roomTabView.addSubview(roomLineView)
        roomLineView.frame = CGRect(x: horPadding, y: topViewHeight - viewLineHieght, width: roomTabView.frame.width - horPadding * 2, height: viewLineHieght)
        roomLineView.backgroundColor = .blue
        roomLineView.isHidden = true
        roomBtn.setTitleColor(.blue, for: .selected)
        roomBtn.setTitleColor(.black, for: .normal)
        
    }
    
    func setSelectTabBlock(block:@escaping (SELECTTAB_FREINDANDROOM)->Void) {
        selectTabBlock = block
    }
    
    fileprivate func actionFreindTab(sender:UIButton) {
        freindLineView.isHidden = sender.isSelected
        roomLineView.isHidden = !sender.isSelected
        if let block = self.selectTabBlock {
            block(.SELECT_FREINDTAB)
        }
    }
    
    fileprivate func actionRoomTab(sender:UIButton) {
        roomLineView.isHidden = sender.isSelected
        freindLineView.isHidden = !sender.isSelected
        if let block = self.selectTabBlock {
            block(.SELECT_ROOMTAB)
        }
    }

}
