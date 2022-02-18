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
        
        colorBtn.clipsToBounds = true
        colorBtn.layer.borderWidth = 5.0
        colorBtn.layer.borderColor = UIColor.white.cgColor
        self.addSubview(colorBtn)
        colorBtn.translatesAutoresizingMaskIntoConstraints = false
        colorBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        colorBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        colorBtn.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        colorBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        colorBtn.addAction { p1 in
            if let block = self.colorBtnblock {
                block(p1.backgroundColor!)
            }
        }
    }
    
    func setSelectColorBtnBlock(block: @escaping (UIColor) -> Void) {
        colorBtn.addAction { p1 in
            if let bgColor = self.colorBtn.backgroundColor {
                block(bgColor)
            }
        }
    }
    
    func setCornerRadius(radius:CGFloat) {
        colorBtn.layer.cornerRadius = radius
    }
    
    func setColor(color:UIColor) {
        colorBtn.backgroundColor = color
    }

}
