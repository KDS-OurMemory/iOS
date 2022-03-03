//
//  OurMemoryRoomsCollectionViewCell.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/23.
//

import UIKit

class OurMemoryRoomsCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var roomProfileImage: UIImageView!
    @IBOutlet weak var roomNameLbl: UILabel!
    @IBOutlet weak var userCntLbl: UILabel!
  

    func setData(data:RoomDataBinder) {
        roomNameLbl.text = data.getName()
        userCntLbl.text = "\(data.getUserCnt())"
        roomProfileImage.image = UIImage(systemName: (data.getUserCnt() > 1 ? "person.3.fill":"person.fill"))
    }
}
