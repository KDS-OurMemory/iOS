//
//  MakeRoomViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/13.
//

import UIKit

class MakeRoomViewController: BaseViewController {

    let topView:TopView = TopView()
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var selectItemSv: BaseScrollView!
    @IBOutlet weak var userListCollectionView: UICollectionView!
    
    override func prepareViewWithData(data: Any?) {
        topViewContainer.addSubview(topView)
        topView.setTitle(title: "일정 공유방 생성")
        topView.setLeftBtn(btnTitle: nil, btnImage: UIImage.init(named: "")) {
            
        }
        
        topView.setRightBtn(btnTitle: nil, btnImage: UIImage.init(named: "")) {
            
        }
    }


}
