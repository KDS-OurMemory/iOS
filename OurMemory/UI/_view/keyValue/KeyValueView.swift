//
//  KeyValueView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/25.
//

import UIKit

class KeyValueView: BaseView {

    let keyLbl:UILabel = UILabel()
    let valueLbl:UILabel = UILabel()
    
    override func prepareViews() {
        
        let horPadding = 15.0
        let viewWidth = mainWidth - horPadding*2
        let viewHeight = 60.0
        let keyLblWidth = viewWidth * 0.3
        let valueLblWidth = viewWidth * 0.7
        
        self.addSubview(self.keyLbl)
        self.addSubview(self.valueLbl)
        
        self.frame = CGRect(x: 0, y: 0, width: mainWidth, height: viewHeight)
        
        keyLbl.textColor = .black
        valueLbl.textColor = .black
        
        keyLbl.textAlignment = .left
        valueLbl.textAlignment = .right
        
        keyLbl.frame = CGRect(x: horPadding, y: 0, width: keyLblWidth, height: viewHeight)
        valueLbl.frame = CGRect(x: keyLblWidth, y: 0, width: valueLblWidth, height: viewHeight)
    }
    
    func setKeyAndValueTitle(key:String, value:String) {
        keyLbl.text = key
        valueLbl.text = value
    }

}
