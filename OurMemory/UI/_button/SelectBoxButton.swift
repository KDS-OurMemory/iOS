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
        self.setImage(UIImage(systemName: "scribble"), for: .normal)
        self.setImage(UIImage(systemName: "scribble.variable"), for: .selected)
        self.semanticContentAttribute = .forceLeftToRight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
