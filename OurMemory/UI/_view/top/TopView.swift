//
//  topView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/13.
//

import UIKit

class TopView: BaseView {

    let titleLbl:UILabel = UILabel()
    let leftBtn:UIButton = UIButton()
    let rightBtn:UIButton = UIButton()
    
    override func prepareViews() {
        let btnWidth = mainWidth*0.2
        let titleWidth = mainWidth - btnWidth * 2
        
        self.frame = CGRect(x: 0, y: 0, width: mainWidth, height: topViewHeight)
        
        leftBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: topViewHeight)
        titleLbl.frame = CGRect(x: btnWidth, y: 0, width: titleWidth, height: topViewHeight)
        rightBtn.frame = CGRect(x: mainWidth-btnWidth, y: 0, width: btnWidth, height: topViewHeight)
        
        self.addSubview(leftBtn)
        self.addSubview(titleLbl)
        self.addSubview(rightBtn)
        
        
        leftBtn.isHidden = true
        rightBtn.isHidden = true
        titleLbl.textColor = .black
        titleLbl.textAlignment = .center
    }
    
    func setTitle(title:String) {
        titleLbl.text = title
    }
    
    func setLeftBtn(btnTitle:String?,btnImage:UIImage?,leftBtnBlock:@escaping ()->Void) {
        leftBtn.isHidden = false
        if let title = btnTitle {
            leftBtn.setTitle(title, for: .normal)
        }
        if let image = btnImage {
            leftBtn.setImage(image, for: .normal)
        }
        leftBtn.addAction { p1 in
            leftBtnBlock()
        }
    }
    
    func setRightBtn(btnTitle:String?,btnImage:UIImage?,rightBtnBlock:@escaping ()->Void) {
        rightBtn.isHidden = false
        if let title = btnTitle {
            rightBtn.setTitle(title, for: .normal)
        }
        if let image = btnImage {
            rightBtn.setImage(image, for: .normal)
        }

        rightBtn.addAction { p1 in
            rightBtnBlock()
        }
    }
    
    

}
