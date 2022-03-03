//
//  AddFreindViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/13.
//

import UIKit
import OurMemoryTask

enum ADDFRIENDSCOLLECTION_SECTION:Int {
    case ADDFRIENDSSEARCH_SECTION = 0
    case ACCEPTADDFRIENDS_SECTION = 1
    case ADDFRIENDSLIST_SECTION = 2
}

class AddFreindViewController: BaseViewController {

    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var freindSearchTypeTabContainer: UIView!
    @IBOutlet weak var friendSearchIDResultCollectionView: UICollectionView!
    @IBOutlet weak var friendSearchNameResultCollectionView: UICollectionView!
    
    var addFriendsCtl:AddFriendContract?
    var addFriendsIDCtl:AddFriendsIDContract?
    var addFriendNameCtl:AddFriendNameContract?
    
    let filterBtnView:FriendsSearchFilterBtnsView = FriendsSearchFilterBtnsView()
    let topView:TopView = TopView()
    let addFriendsIDAdapter:AddFriendsSearchIDCollectionAdapter = AddFriendsSearchIDCollectionAdapter()
    let addFriendsNameAdapter:AddFriendsSearchNameCollectionAdapter = AddFriendsSearchNameCollectionAdapter()
    
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var qrView: UIView!
    @IBOutlet weak var friendsIDView: UIView!
    @IBOutlet weak var friendsNameView: UIView!
    
    override func getDataContract() -> DataContract? {
        self.addFriendsCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        
        if self.getDataContract() == nil {
            addFriendsCtl = CtlMaker().createDataControllerWithContract(contract: .eContractAddFriend, view: self, data: data) as? AddFriendContract
            addFriendsIDCtl = CtlMaker().createDataControllerWithContract(contract: .eContractAddFriendSearchID, view: self, data: data) as? AddFriendsIDContract
            addFriendsIDCtl?.setCollectionWithAdpater(adapter: addFriendsIDAdapter)
            addFriendsIDAdapter.setCollection(collectionView: friendSearchIDResultCollectionView)
            addFriendNameCtl = CtlMaker().createDataControllerWithContract(contract: .eContractAddFriendSearchName, view: self, data: data) as? AddFriendNameContract
            addFriendNameCtl?.setCollectionWithAdpater(adapter: addFriendsNameAdapter)
            addFriendsNameAdapter.setCollection(collectionView: friendSearchNameResultCollectionView)
        }
        
        recommendView.isHidden = false
        qrView.isHidden = true
        friendsIDView.isHidden = true
        friendsNameView.isHidden = true
        
        topViewContainer.addSubview(topView)
        topView.setTitle(title: "친구 찾기")
        
        topView.setLeftBtn(btnTitle: nil, btnImage: UIImage(systemName: "xmark")) {
            self.showNextVC(vc: .NEXTVIEW_POP, data: nil)
        }
        
        freindSearchTypeTabContainer.addSubview(filterBtnView)
        filterBtnView.frame = CGRect(x: 0, y: 0, width: freindSearchTypeTabContainer.frame.width, height: freindSearchTypeTabContainer.frame.height)
        filterBtnView.setFilterBtnBlock { p1 in
            switch p1 {
            case .RECOMMEND:
                break
            case .QR:
                break
            case .ID:
                if let ctl = self.addFriendsCtl {
                    ctl.switchFriendsSearchForIDTab()
                }
                break
            case .NAME:
                if let ctl = self.addFriendsCtl {
                    ctl.switchFriendsSearchForNameTab()
                }
                break
            }
            
        }
        
        friendSearchIDResultCollectionView.registCell(cellIdentifier: NoItemCollectionViewCell.className())
        friendSearchIDResultCollectionView.registCell(cellIdentifier: SearchCollectionViewCell.className())
        friendSearchIDResultCollectionView.registCell(cellIdentifier: AddFriendsCollectionCell.className())
        
        friendSearchNameResultCollectionView.registCell(cellIdentifier: NoItemCollectionViewCell.className())
        friendSearchNameResultCollectionView.registCell(cellIdentifier: SearchCollectionViewCell.className())
        friendSearchNameResultCollectionView.registCell(cellIdentifier: AddFriendsCollectionCell.className())
        
    }
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
        case .NEXTVIEW_POP:
            self.navigate(vc, animation: true, data: data, onInitVc: nil)
            break
        default:
            break
        }
    }
    
}

extension AddFreindViewController:AddFriendsView {
    
    func updateSelectTabIndex(idx:Int) {
        filterBtnView.selectTabIndex(index: idx)
    }
    
    func updateRecommendFriendList() {
        self.recommendView.isHidden = false
        self.qrView.isHidden = true
        self.friendsIDView.isHidden = true
        self.friendsNameView.isHidden = true
        
        if let ctl = self.addFriendsIDCtl {
            ctl.switchTab()
        }
        if let ctl = self.addFriendNameCtl {
            ctl.switchTab()
        }
    }
    
    func updateMyQR() {
        self.recommendView.isHidden = true
        self.qrView.isHidden = false
        self.friendsIDView.isHidden = true
        self.friendsNameView.isHidden = true
        
        if let ctl = self.addFriendsIDCtl {
            ctl.switchTab()
        }
        if let ctl = self.addFriendNameCtl {
            ctl.switchTab()
        }
    }
    
    func updateUserListAtSearchID() {
        self.recommendView.isHidden = true
        self.qrView.isHidden = true
        self.friendsIDView.isHidden = false
        self.friendsNameView.isHidden = true
        if let ctl = self.addFriendsIDCtl {
            ctl.activeIDTab()
        }
        if let ctl = self.addFriendNameCtl {
            ctl.switchTab()
        }
    }
    
    func updateUserListAtSearchName() {
        self.recommendView.isHidden = true
        self.qrView.isHidden = true
        self.friendsIDView.isHidden = true
        self.friendsNameView.isHidden = false
        
        if let ctl = self.addFriendsIDCtl {
            ctl.switchTab()
        }
        if let ctl = self.addFriendNameCtl {
            ctl.activeNameTab()
        }
    }
    
    
}

extension AddFreindViewController:AddFriendsIDView {
    
    
}

extension AddFreindViewController:AddFriendNameView {
    
}
