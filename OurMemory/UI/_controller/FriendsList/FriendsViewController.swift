//
//  FriendsViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/03/04.
//

import UIKit

class FriendsViewController: BaseViewController {

    @IBOutlet weak var freindView: BaseView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var addFriendsBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var topViewContainer: UIView!
    
    let topView = TopView()
    var friendsCtl:OurMemoryFriendsTabContract?
    let friendsAdapter:FriendsCollectionAdapter = FriendsCollectionAdapter()

    override func getDataContract() -> DataContract? {
        return self.friendsCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        
        if self.getDataContract() == nil {
            
            topViewContainer.addSubview(topView)
            topView.setTitle(title: "친구 목록")
            topView.setLeftBtn(btnTitle: nil, btnImage: UIImage(systemName: "arrow.left")) {
                self.showNextVC(vc: .NEXTVIEW_POP, data: nil)
            }
            friendsAdapter.setCollection(collectionView: friendsCollectionView)
            friendsCtl = CtlMaker().createDataControllerWithContract(contract: .eContractOurMemoryFreindsTab, view: self, data: data) as? OurMemoryFriendsTabContract
            friendsCtl?.setCollectionWithAdpater(adapter: friendsAdapter)
            
            friendsCollectionView.register(UINib(nibName: NoItemCollectionViewCell.className() , bundle: nil), forCellWithReuseIdentifier: NoItemCollectionViewCell.className())
            friendsCollectionView.register(UINib(nibName: SearchCollectionViewCell.className() , bundle: nil), forCellWithReuseIdentifier: SearchCollectionViewCell.className())
            friendsCollectionView.register(UINib(nibName: OurMemoryFriendsCollectionViewCell.className() , bundle: nil), forCellWithReuseIdentifier: OurMemoryFriendsCollectionViewCell.className())
            if let ctl = self.getDataContract() as? OurMemoryFriendsTabContract {
                self.addFriendsBtn.addAction { p1 in
                    ctl.actionAddFriendBtn(sender: p1 as! UIButton)
                }
                
                self.searchBtn.addAction { p1 in
                    ctl.actionSearchBtn(sender: p1 as! UIButton)
                }
                
                self.settingsBtn.addAction { p1 in
                    ctl.actionSettingsBtn(sender: p1 as! UIButton)
                }
            }
        }
        
    }
    
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
        case .NEXTVIEW_POP:
            self.navigate(vc, animation: true, data: data, onInitVc: nil)
            break
        case .NEXTVIEW_ADDFRIENDS:
            self.navigate(vc, animation: true, data: data, onInitVc: nil)
            break
        default:
            break
        }
}


}
extension FriendsViewController: OurMemoryFriendsTabView {
    
    
}
