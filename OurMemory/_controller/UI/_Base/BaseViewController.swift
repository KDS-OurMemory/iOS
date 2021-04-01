//
//  BaseViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/03/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
    }

    func inittailizeSubView() -> Self {
        
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    func inittailizeSubViewClass() -> Self {
        
        func loadNibInViewController<T: UIViewController>() -> T {
            let nib = UINib(nibName: String(describing:T.self), bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as! T
        }
        
        return loadNibInViewController()
    }
    
    

}
