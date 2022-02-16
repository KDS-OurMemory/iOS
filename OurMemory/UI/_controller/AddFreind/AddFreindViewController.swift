//
//  AddFreindViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/13.
//

import UIKit

class AddFreindViewController: BaseViewController {

    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var freindSearchTypeTabContainer: UIView!
    
    @IBOutlet weak var freindSearchResultCollectionView: UICollectionView!
    let topView:TopView = TopView()
    
    override func prepareViewWithData(data: Any?) {
        
        topViewContainer.addSubview(topView)
        topView.setTitle(title: "친구 찾기")
        
        topView.setLeftBtn(btnTitle: nil, btnImage: UIImage.init(named: "")) {
            
        }
        
    }
    
}
