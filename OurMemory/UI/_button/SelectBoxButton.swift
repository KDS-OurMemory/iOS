//
//  SelectBoxButton.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/11.
//

import UIKit

class SelectBoxButton: UIButton {

    init() {
        super.init(frame: CGRect.zero)
        self.frame.size = CGSize(width: mainWidth, height: 40)
        self.setImage(UIImage(named: ""), for: .normal)
        self.setImage(UIImage(named: ""), for: .selected)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
