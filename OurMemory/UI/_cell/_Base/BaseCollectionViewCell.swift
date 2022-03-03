//
//  baseCollectionViewCell.swift
//  OurMemory
//
//  Created by 이승기 on 2021/05/21.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
 
    var cellId:String = ""
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.__init__()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.__init__()
    }
    
    func __init__() {
        cellId = self.description
    }
    
}
