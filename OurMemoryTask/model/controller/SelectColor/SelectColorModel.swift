//
//  SelectColorModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/11.
//

import UIKit

enum SELECTCOLOR_RESULT:UInt {
    case UPDATE_COLORS
}

class SelectColorModel: NSObject {
    
    var selectColorCallback:UINTANY_VOID?
    var defaultColors:[UIColor] =
    [
        .black,.brown,.cyan,.darkGray,.gray,
        .blue,.green,.magenta,.lightGray,.darkText,
        .orange,.purple,.red,.yellow,.white,
    ]
    
    func initWithCallback(callback: @escaping UINTANY_VOID) {
        selectColorCallback = callback
        if let block = self.selectColorCallback {
            block(SELECTCOLOR_RESULT.UPDATE_COLORS.rawValue,defaultColors)
        }
    }
    
}
