//
//  FriendsSearchFilterBtnsView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/21.
//

import UIKit

enum BTNFILTER_TYPE:Int {
    case RECOMMEND
    case QR
    case ID
    case NAME
}

class FriendsSearchFilterBtnsView: BaseView {

    let recommendBtn:UIButton = UIButton()
    let recommendBtnBotViewLine:UIView = UIView()
    
    let qrBtn:UIButton = UIButton()
    let qrBtnBotViewLine:UIView = UIView()
    
    let idBtn:UIButton = UIButton()
    let idBtnBotViewLine:UIView = UIView()
    
    let nameBnt:UIButton = UIButton()
    let nameBtnBotViewLine:UIView = UIView()
    
    var btns:[UIButton] = []
    var filterBlock:((BTNFILTER_TYPE) -> Void)?
    
    override func prepareViews() {
        let btnSize = CGSize(width: mainWidth*0.25, height: 60.0)
        let viewLineHeight = 2.0
        
        self.addSubview(recommendBtn)
        recommendBtn.addSubview(recommendBtnBotViewLine)
        self.addSubview(qrBtn)
        qrBtn.addSubview(qrBtnBotViewLine)
        self.addSubview(idBtn)
        idBtn.addSubview(idBtnBotViewLine)
        self.addSubview(nameBnt)
        nameBnt.addSubview(nameBtnBotViewLine)
        
        recommendBtn.frame = CGRect(x: 0, y: 0, width: btnSize.width, height: btnSize.height)
        qrBtn.frame = CGRect(x: btnSize.width, y: 0, width: btnSize.width, height: btnSize.height)
        idBtn.frame = CGRect(x: btnSize.width*2, y: 0, width: btnSize.width, height: btnSize.height)
        nameBnt.frame = CGRect(x: btnSize.width*3, y: 0, width: btnSize.width, height: btnSize.height)
        
        
        recommendBtn.setTitle("추천", for: .normal)
        qrBtn.setTitle("QR", for: .normal)
        idBtn.setTitle("ID", for: .normal)
        nameBnt.setTitle("이름", for: .normal)
        
        recommendBtn.setTitleColor(.black, for: .normal)
        recommendBtn.setTitleColor(.blue, for: .selected)
        qrBtn.setTitleColor(.black, for: .normal)
        qrBtn.setTitleColor(.blue, for: .selected)
        idBtn.setTitleColor(.black, for: .normal)
        idBtn.setTitleColor(.blue, for: .selected)
        nameBnt.setTitleColor(.black, for: .normal)
        nameBnt.setTitleColor(.blue, for: .selected)
        
        
        recommendBtnBotViewLine.frame = CGRect(x: 0, y: btnSize.height - viewLineHeight, width: btnSize.width, height: viewLineHeight)
        
        qrBtnBotViewLine.frame = CGRect(x: 0, y: btnSize.height - viewLineHeight, width: btnSize.width, height: viewLineHeight)
        
        idBtnBotViewLine.frame = CGRect(x: 0, y: btnSize.height - viewLineHeight, width: btnSize.width, height: viewLineHeight)
        
        nameBtnBotViewLine.frame = CGRect(x: 0, y: btnSize.height - viewLineHeight, width: btnSize.width, height: viewLineHeight)
        
        recommendBtn.backgroundColor = .gray
        qrBtn.backgroundColor = .gray
        idBtn.backgroundColor = .gray
        nameBnt.backgroundColor = .gray
        
        recommendBtn.tag = BTNFILTER_TYPE.RECOMMEND.rawValue
        qrBtn.tag = BTNFILTER_TYPE.QR.rawValue
        idBtn.tag = BTNFILTER_TYPE.ID.rawValue
        nameBnt.tag = BTNFILTER_TYPE.NAME.rawValue
        
        btns.append(recommendBtn)
        btns.append(qrBtn)
        btns.append(idBtn)
        btns.append(nameBnt)
    }
    
    func setFilterBtnBlock(block:@escaping (BTNFILTER_TYPE)->Void) {
        
        filterBlock = block
        
        recommendBtn.addAction { p1 in
            self.recommendBtnBotViewLine.backgroundColor = (self.recommendBtn.isSelected ? .blue:.clear)
            block(BTNFILTER_TYPE.RECOMMEND)
        }
        
        qrBtn.addAction { p1 in
            self.qrBtnBotViewLine.backgroundColor = (self.qrBtn.isSelected ? .blue:.clear)
            block(BTNFILTER_TYPE.QR)
            
        }
        
        idBtn.addAction { p1 in
            self.idBtnBotViewLine.backgroundColor = (self.idBtn.isSelected ? .blue:.clear)
            block(BTNFILTER_TYPE.ID)
            
        }
        nameBnt.addAction { p1 in
            self.nameBtnBotViewLine.backgroundColor = (self.nameBnt.isSelected ? .blue:.clear)
            block(BTNFILTER_TYPE.NAME)
            
        }
    }
    
    func selectTabIndex(index:Int) {
        let idx = BTNFILTER_TYPE.init(rawValue: index)
        
            switch idx {
            case .RECOMMEND:
                if recommendBtn.isSelected { recommendBtn.isSelected = true }
                break
            case .ID:
                if idBtn.isSelected { idBtn.isSelected = true }
                break
            case .NAME:
                if nameBnt.isSelected { nameBnt.isSelected = true }
                break
            case .QR:
                if qrBtn.isSelected { qrBtn.isSelected = true }
                break
            default:
                break
            }
            for btn in btns {
                if btn.tag != index {
                    btn.isSelected = false
                    btn.subviews.first!.backgroundColor = .clear
                }else {
                    btn.isSelected = true
                    btn.subviews.first!.backgroundColor = .blue
                }
            }
        
        
    }

}
