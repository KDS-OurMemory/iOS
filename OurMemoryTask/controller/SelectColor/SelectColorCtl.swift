//
//  SelectColorCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import UIKit

class SelectColorCtl: BaseCtl {

    let selectColorModel:SelectColorModel = SelectColorModel()
    
    override func __initWithData__(data: Any?) {
        selectColorModel.initWithCallback { p1, p2 in
            let result = SELECTCOLOR_RESULT.init(rawValue: p1)
            switch result {
            case .UPDATE_COLORS:
                self.callUpdateColors(colors: p2 as! [UIColor])
                break
            case .none:
                break
            }
        }
    }
    
    fileprivate func callUpdateColors(colors:[UIColor]) {
        if let view = self.view as? SelectColorView {
            view.updateColors(colors: colors)
        }
    }
}
