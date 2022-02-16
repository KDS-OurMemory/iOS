//
//  colorItem.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/12.
//

import UIKit

class ColorItemView: BaseView {
    
    var colorBtn:UIButton = UIButton()
    var colorBtnblock:((UIColor) -> Void)?
    
    override func prepareViews() {
        colorBtn.setTitle("", for: .normal)
        colorBtn.layer.cornerRadius = 50
        self.addSubview(colorBtn)
        
        colorBtn.addAction { p1 in
            if let block = self.colorBtnblock {
                block(p1.backgroundColor!)
            }
        }
    }
    
    func setSelectColorBtnBlock(block: @escaping (UIColor) -> Void) {
        colorBtnblock = block
    }
    
    func setColor(color:UIColor) {
        colorBtn.backgroundColor = color
    }

}
