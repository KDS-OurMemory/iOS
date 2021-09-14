//
//  BaseView.swift
//  OurMemory
//
//  Created by 이승기 on 2021/05/04.
//

import UIKit

class BaseView: UIView {

    
    func initiailizeSubViewClass() -> Self {
        
        func loadNibInViewController<T: UIView>() -> T {
            let nib = UINib(nibName: String(describing:T.self), bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as! T
        }
        
        return loadNibInViewController()
    }

}
