//
//  UIControler+AddAction.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/09.
//

import Foundation
import UIKit

extension UIControl {
    
    func addAction(block:@escaping (UIControl) -> Void ) {
        let action:UIAction = UIAction { _ in
            block(self)
        }
        self.addAction(action, for: .touchUpInside)
    }
    
}

