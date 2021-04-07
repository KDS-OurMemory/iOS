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
}

class RoomDetailCalCollectionViewCell: UICollectionViewCell,roomDetailCalCell {
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var dateNumLbl: UILabel!
    
    func setDate(date:calCellData) {
        dateNumLbl.text = date.num
        switch date.state {
        case .prev:
            
            break
        case .current:
            break
        case .next:
            break
        default:
            break
        }
    }
    
    func setViewLine(flag:Bool) {
        self.viewLine.isHidden = flag
    }
}
