//
//  SelectedDateItemView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/17.
//

import UIKit

class SelectedDateItemView: BaseView {

    let dateLbl = UILabel()
    let dateItemBtn = UIButton()
    
    override func prepareViews() {
        dateLbl.textAlignment = .center
        dateLbl.numberOfLines = 0
        dateLbl.lineBreakMode = .byWordWrapping
        self.addSubview(dateLbl)
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        
        dateLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dateLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        dateLbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dateLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        dateItemBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dateItemBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        dateItemBtn.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dateItemBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func setDateLbl(date:String) {
        dateLbl.text = date
    }
    
    func setTrySelectDateItemBlock(block:@escaping (Int) -> Void) {
        dateItemBtn.addAction { p1 in
            block(self.tag)
        }
    }
}
