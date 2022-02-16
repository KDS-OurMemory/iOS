//
//  BaseView.swift
//  OurMemory
//
//  Created by 이승기 on 2021/05/04.
//

import UIKit

class BaseView: UIView {

    var lastSubViewYPosition:CGFloat = 0
    
    func initiailizeSubViewClass() -> Self {
        
        func loadNibInViewController<T: UIView>() -> T {
            let nib = UINib(nibName: String(describing:T.self), bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as! T
        }
        
        return loadNibInViewController()
    }
    
    init() {
        super.init(frame: .zero)
        self.prepareViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.prepareViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareViews()
    }
    
    func prepareViews() {
        
    }
    
    func addVerSubView(subView:UIView,viewHeight:CGFloat ,verPadding:CGFloat) {
        self.addSubview(subView)
        subView.frame = CGRect(x: 0, y: lastSubViewYPosition + verPadding, width: mainWidth , height: viewHeight)
        self.frame = CGRect(x: 0, y: self.frame.origin.y, width: mainWidth, height: self.frame.size.height + viewHeight + verPadding)
        lastSubViewYPosition = lastSubViewYPosition + viewHeight + verPadding
    }

}
