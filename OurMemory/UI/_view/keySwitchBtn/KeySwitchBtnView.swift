//
//  KeyOnOffView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/25.
//

import UIKit

class KeySwitchBtnView: BaseView {

    let keyLbl:UILabel = UILabel()
    let switchOnBtn:UIButton = UIButton()
    let switchOffBtn:UIButton = UIButton()
    
    override func prepareViews() {
        
        let horPadding = 15.0
        let viewWidth = mainWidth - horPadding*2
        let viewHeight = 60.0
        let keyLblWidth = viewWidth * 0.3
        let switchBtnWidth = viewWidth * 0.18
        
        self.addSubview(self.keyLbl)
        self.addSubview(self.switchOnBtn)
        self.addSubview(self.switchOffBtn)
        
        self.frame = CGRect(x: 0, y: 0, width: mainWidth, height: viewHeight)
        
        keyLbl.textColor = .black
        switchOnBtn.setTitleColor(.black, for: .normal)
        switchOffBtn.setTitleColor(.black, for: .normal)
        switchOnBtn.setTitleColor(.white, for: .selected)
        switchOffBtn.setTitleColor(.white, for: .selected)
        
        keyLbl.textAlignment = .left
        
        keyLbl.frame = CGRect(x: horPadding, y: 0, width: keyLblWidth, height: viewHeight)
        switchOnBtn.frame = CGRect(x: viewWidth - horPadding - switchBtnWidth*2, y: 0, width: switchBtnWidth, height: viewHeight)
        switchOffBtn.frame = CGRect(x: viewWidth - horPadding - switchBtnWidth, y: 0, width: switchBtnWidth, height: viewHeight)
    }
    
    func setKeyAndValueTitle(key:String, values:(String,String)) {
        keyLbl.text = key
        switchOnBtn.setTitle(values.0, for: .normal)
        switchOffBtn.setTitle(values.1, for: .normal)
    }
    
    func setOnOffBtnState(state:Bool) {
        switchOnBtn.isSelected = state
        switchOffBtn.isSelected = !state
        switchOnBtn.backgroundColor = (state ? .black:.white)
        switchOffBtn.backgroundColor = (state ? .white:.black)
    }
    
    
    
    func setOnOffBlock(block:@escaping (Bool) -> Void) {
     
        switchOnBtn.addAction { p1 in
            self.setOnOffBtnState(state: true)
            block(true)
        }
        
        switchOffBtn.addAction { p1 in
            self.setOnOffBtnState(state:false)
            block(false)
        }
        
    }

}
