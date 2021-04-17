//
//  RoomDetailCalCollectionViewCell.swift
//  OurMemory
//
//  Created by 이승기 on 2021/04/05.
//

import UIKit

enum dateState {
    case prev
    case current
    case next
    case unknown
}

struct calCellData {
    let num:String
    let state:dateState
    let weekDay:WEEKDAYS
    let weekPoint:Int
}

class RoomDetailCalCollectionViewCell: UICollectionViewCell,roomDetailCalCell {
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var dateNumLbl: UILabel!
    @IBOutlet weak var workCntImg: UIImageView!
    @IBOutlet weak var firstWork: UILabel!
    @IBOutlet weak var secWork: UILabel!
    @IBOutlet weak var thirdWork: UILabel!
    @IBOutlet weak var forWork: UILabel!
    @IBOutlet weak var workView: UIView!
    
    @IBOutlet weak var workCntLbl: UILabel!
    @IBOutlet weak var workNameLbl: UILabel!
    
    @IBOutlet var workCntTrailingConst: NSLayoutConstraint!
    @IBOutlet var workCntBottomConst: NSLayoutConstraint!
    
    func setImageWithCnt(cnt:Int) {
        switch cnt {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        default:
            break
        }
    }
    
    func setDate(date:calCellData) {
        
        self.viewLine.backgroundColor = UIColor.darkGray
        self.dateNumLbl.text = date.num
        
        switch date.state {
        case .prev:
            if date.weekDay == WEEKDAYS.SUNDAY
            {
                self.dateNumLbl.textColor = UIColor.init(red: 150/255.0, green: 1/255.0, blue: 1/255, alpha: 1)
            }else
            {
                self.dateNumLbl.textColor = UIColor.init(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
            }
            break
        case .current:
            if date.weekDay == WEEKDAYS.SUNDAY
            {
                self.dateNumLbl.textColor = UIColor.init(red: 255/255.0, green: 1/255.0, blue: 1/255, alpha: 1)
            }else {
                self.dateNumLbl.textColor = UIColor.white
            }
            break
        case .next:
            self.dateNumLbl.textColor = UIColor.init(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
            break
        default:
            break
        }
    }
    
    func changeStateCell(data:calCellData,state:ROOMDETAILSCROLLPOINT) {
        switch state {
        case .TOPMIDTOP:
            break
        case .TOPMIDBOT:
            self.viewLine.isHidden = true
            break
        case .MID:
            self.workCntImg.alpha = 1.0
            self.workView.alpha = 0
            self.viewLine.isHidden = true
            break
        case .BOTMIDTOP:
            dateNumLbl.font = dateNumLbl.font.withSize(10)
            self.workCntImg.alpha = 0.7
            self.workCntBottomConst.constant = -self.workCntLbl.frame.size.height
            self.workView.alpha = 0.3
            if data.weekPoint != 0 {
                self.viewLine.isHidden = false
                self.viewLine.alpha = 0.3
            }else {
                self.viewLine.isHidden = true
            }
            break
        case .BOTMIDBOT:
            self.workCntImg.alpha = 0.3
            self.workCntBottomConst.constant = -self.workCntLbl.frame.size.height/2
            self.workView.alpha = 0.7
            if data.weekPoint != 0 {
                self.viewLine.isHidden = false
                self.viewLine.alpha = 0.7
            }else {
                self.viewLine.isHidden = true
            }
            break
        case .OUTSCREEN:
            dateNumLbl.font = dateNumLbl.font.withSize(8)
            self.workCntImg.alpha = 0.0
            self.workCntBottomConst.constant = 0
            self.workView.alpha = 1.0
            if data.weekPoint != 0 {
                self.viewLine.isHidden = false
                self.viewLine.alpha = 1.0
            }else {
                self.viewLine.isHidden = true
            }
            break
        case .UNKWNON:
            break
        }
        
        
        
    }
    
}
