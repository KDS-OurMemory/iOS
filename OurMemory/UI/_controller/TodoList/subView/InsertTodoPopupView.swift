//
//  InsertTodoPopupView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/03/18.
//

import UIKit

class InsertTodoPopupView: BaseView,UITextFieldDelegate {

    let dateLbl = UILabel()
    let contentInfoLbl = UILabel()
    let todoContentTf = UITextField()
    let selectCalBtn = UIButton()
    let confirmBtn = UIButton()
    let cancelBtn = UIButton()
    
    override func prepareViews() {
        let verPadding = 20.0
        let horPadding = 20.0
        let viewHeight = 450.0
        let viewWidth = mainWidth-horPadding*2
        let insideHorPadding = 10.0
        let calBtnWidth = 30.0
        let contentHeight = 30.0
        let contentWidth = viewWidth - insideHorPadding*2
        let actionBtnSize = CGSize(width: 50, height: 40)
        
        todoContentTf.delegate = self
        
        self.addSubview(dateLbl)
        self.addSubview(selectCalBtn)
        self.addSubview(contentInfoLbl)
        self.addSubview(todoContentTf)
        self.addSubview(confirmBtn)
        self.addSubview(cancelBtn)
        
        dateLbl.frame = CGRect(x: insideHorPadding, y: verPadding, width: viewWidth - calBtnWidth - insideHorPadding, height: contentHeight)
        selectCalBtn.frame = CGRect(x:viewWidth - calBtnWidth - insideHorPadding , y: verPadding, width: calBtnWidth, height: contentHeight)
        contentInfoLbl.frame = CGRect(x: insideHorPadding, y: verPadding+contentHeight, width:contentWidth , height: contentHeight)
        todoContentTf.frame = CGRect(x: insideHorPadding, y: (verPadding+contentHeight)*2+verPadding*2, width: contentWidth, height: contentHeight)
        confirmBtn.frame = CGRect(x: viewHeight - insideHorPadding, y: todoContentTf.frame.maxY + verPadding*2, width: actionBtnSize.width, height: actionBtnSize.height)
        cancelBtn.frame = CGRect(x: confirmBtn.frame.minX - actionBtnSize.width - insideHorPadding, y: confirmBtn.frame.minX, width: actionBtnSize.width, height: actionBtnSize.height)
        
        self.frame = CGRect(x: horPadding, y: 0, width: viewWidth , height: viewHeight)
    }
}
