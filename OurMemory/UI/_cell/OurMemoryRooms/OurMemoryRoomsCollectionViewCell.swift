//
//  OurMemoryRoomsCollectionViewCell.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/23.
//

import UIKit

class OurMemoryRoomsCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var roomProfileBtn: UIButton!
    @IBOutlet weak var roomNameLbl: UILabel!
    @IBOutlet weak var userCntLbl: UILabel!
    @IBOutlet weak var roomCellBtn: UIButton!
    

    func setData(data:RoomDataBinder) {
        roomNameLbl.text = data.getName()
        userCntLbl.text = "\(data.getUserCnt())"
        roomProfileBtn.setImage(UIImage(systemName: (data.getUserCnt() > 1 ? "person.3.fill":"person.fill")), for: .normal)
    }
    
    func clickBlock(block:@escaping (UICollectionViewCell) -> Void) {
        self.roomCellBtn.addAction { p1 in
            block(self)
        }
    }
}
