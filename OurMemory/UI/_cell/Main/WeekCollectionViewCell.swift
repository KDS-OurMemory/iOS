//
//  WeekCollectionViewCell.swift
//  OurMemory
//
//  Created by 이승기 on 2021/05/21.
//

import UIKit

class WeekCollectionViewCell: BaseCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func __init__() {
        self.setRandomBackGroundColor()
    }
  
    private func setRandomBackGroundColor() {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        self.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
