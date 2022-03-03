//
//  KeySwitchView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/25.
//

import UIKit

class KeySwitchView: BaseView {

    let keyLbl:UILabel = UILabel()
    let valueSwitch:UISwitch = UISwitch()
    
    override func prepareViews() {
        
        let horPadding = 15.0
        let viewWidth = mainWidth - horPadding*2
        let viewHeight = 60.0
        let keyLblWidth = viewWidth * 0.3
        let valueSwitchWidth = valueSwitch.frame.width
        let valueSwitchHeight = valueSwitch.frame.height
        
        self.addSubview(self.keyLbl)
        self.addSubview(self.valueSwitch)
        
        self.frame = CGRect(x: 0, y: 0, width: mainWidth, height: viewHeight)
        
        keyLbl.textColor = .black
        
        keyLbl.textAlignment = .left
        
        keyLbl.frame = CGRect(x: horPadding, y: 0, width: keyLblWidth, height: viewHeight)
        valueSwitch.frame.origin = CGPoint(x: viewWidth - valueSwitchWidth, y: viewHeight*0.5-valueSwitchHeight*0.5)
    }
    
    func setKeyAndValueTitle(key:String) {
        keyLbl.text = key
    }
    
    func setSwitchState(state:Bool) {
        valueSwitch.isOn = state
    }
    
    func setSwitchBlock(block:@escaping (Bool) -> Void) {
        valueSwitch.addAction { p1 in
            block(self.valueSwitch.isOn)
        }
    }

}
