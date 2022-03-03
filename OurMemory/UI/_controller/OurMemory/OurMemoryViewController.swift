//
//  OurMemoryViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit
import OurMemoryTask

class OurMemoryViewController: BaseViewController {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var addFriendsAndAddRoomsBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    var ourMemoryCtl:OurMemoryContract?
    var friendsCtl:OurMemoryFriendsTabContract?
    var roomsCtl:OurMemoryRoomsTabContract?
    @IBOutlet weak var tabViewContainer: UIView!
    @IBOutlet weak var searchFreindSettingBtnContainer: UIView!
    @IBOutlet weak var freindView: BaseView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    @IBOutlet weak var roomView: BaseView!
    @IBOutlet weak var roomsCollectionView: UICollectionView!
    let tabView:FreindAndRoomTabbarView = FreindAndRoomTabbarView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: topViewHeight))
    var tabbar:TabbarView!
    let friendsAdapter:FriendsCollectionAdapter = FriendsCollectionAdapter()
    let roomsAdapter:RoomsCollectionAdapter = RoomsCollectionAdapter()
    
    override func getDataContract() -> DataContract? {
        return self.ourMemoryCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            
            tabViewContainer.addSubview(tabView)
            tabView.setSelectTabBlock { p1 in
                if let ourMemoryCtl = self.getDataContract() as? OurMemoryContract {
                    switch p1 {
                    case .SELECT_ROOMTAB:
                        if let ctl = self.friendsCtl {
                            ctl.switchRoomsTab()
                            ourMemoryCtl.switchRoomsTab()
                        }
                        break
                    case .SELECT_FREINDTAB:
                        if let ctl = self.roomsCtl {
                            ctl.switchFriendTab()
                            ourMemoryCtl.switchFriendsTab()
                        }
                        break
                    }
                }
            }
            
           
            
            ourMemoryCtl = CtlMaker().createDataControllerWithContract(contract: .eContractOurMemory, view: self, data: data) as? OurMemoryContract
            roomsCtl = CtlMaker().createDataControllerWithContract(contract: .eContractOurMemoryRoomsTab, view: self, data: data) as? OurMemoryRoomsTabContract
            roomsCtl?.setCollectionWithAdpater(adapter: roomsAdapter)
            roomsAdapter.setCollection(collectionView: roomsCollectionView)
            friendsCtl = CtlMaker().createDataControllerWithContract(contract: .eContractOurMemoryFreindsTab, view: self, data: data) as? OurMemoryFriendsTabContract
            friendsCtl?.setCollectionWithAdpater(adapter: friendsAdapter)
            friendsAdapter.setCollection(collectionView: friendsCollectionView)
            friendsCollectionView.register(UINib(nibName: NoItemCollectionViewCell.className() , bundle: nil), forCellWithReuseIdentifier: NoItemCollectionViewCell.className())
            friendsCollectionView.register(UINib(nibName: SearchCollectionViewCell.className() , bundle: nil), forCellWithReuseIdentifier: SearchCollectionViewCell.className())
            friendsCollectionView.register(UINib(nibName: OurMemoryFriendsCollectionViewCell.className() , bundle: nil), forCellWithReuseIdentifier: OurMemoryFriendsCollectionViewCell.className())
            roomsCollectionView.registCell(cellIdentifier: NoItemCollectionViewCell.className())
            roomsCollectionView.registCell(cellIdentifier: SearchCollectionViewCell.className())
            roomsCollectionView.registCell(cellIdentifier: OurMemoryRoomsCollectionViewCell.className())
            self.activeFriendsTabView()

        } else {
            guard let ctl = self.getDataContract() as? OurMemoryContract else { return }
            ctl.reloadView()
            
            if let ctl = self.ourMemoryCtl {
                self.addFriendsAndAddRoomsBtn.addAction { p1 in
                    ctl.actionAddFriendAndAddRoomBtn(sender: p1 as! UIButton)
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
        case .NEXTVIEW_ADDFRIENDS:
            self.navigate(vc, animation: true, data: data, onInitVc: nil)
            break
        case .NEXTVIEW_ADDROOMS:
            self.navigate(vc, animation: true, data: data, onInitVc: nil)
            break
        case .NEXTVIEW_ROOMDETAIL:
            self.navigate(vc, animation: true, data: data, onInitVc: nil)
            break
        default:
            break
        }
    }

}

extension OurMemoryViewController:OurMemoryView {
    
    func updateSearchView() {
        if let friendsCtl = self.friendsCtl, let roomsCtl = self.roomsCtl {
            friendsCtl.updateSearchView()
            roomsCtl.updateSearchView()
        }
    }
    
    
    func setTabbarView(tabView:UIView) {
        if let tabbar = tabView as? TabbarView {
            self.tabbar = tabbar
            self.view.addSubview(tabView)
        }
    }
    
    func updateNotiCnt(items:[UInt:Int]) {
        
    }
    
    func setSearchBlock(searchCallback: @escaping (String) -> Void) {
        
    }
    
    
}

extension OurMemoryViewController: OurMemoryFriendsTabView {
    
    func activeRoomsTabView() {
        if let ctl = self.roomsCtl {
            self.roomView.isHidden = false
            self.freindView.isHidden = true
            self.roomView.isUserInteractionEnabled = true
            self.freindView.isUserInteractionEnabled = false
            ctl.activeRoomsTab()
            addFriendsAndAddRoomsBtn.setImage(UIImage(systemName: "person.3.fill"), for:.normal )
        }
    }
    
    
}

extension OurMemoryViewController: OurMemoryRoomsTabView {
    func activeFriendsTabView() {
        if let ctl = self.friendsCtl {
            self.roomView.isHidden = true
            self.freindView.isHidden = false
            self.roomView.isUserInteractionEnabled = false
            self.freindView.isUserInteractionEnabled = true
            ctl.activeFriendsTab()
            addFriendsAndAddRoomsBtn.setImage(UIImage(systemName: "person.badge.plus.fill"), for:.normal )
        }
    }
    
    
}
