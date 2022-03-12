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
    
    @IBOutlet weak var tabViewContainer: UIView!
    @IBOutlet weak var searchFreindSettingBtnContainer: UIView!

    @IBOutlet weak var roomView: BaseView!
    @IBOutlet weak var roomsCollectionView: UICollectionView!
    let topView = TopView()
    var tabbar:TabbarView!
    
    let roomsAdapter:RoomsCollectionAdapter = RoomsCollectionAdapter()
    
    override func getDataContract() -> DataContract? {
        return self.ourMemoryCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            
            tabViewContainer.addSubview(topView)
            topView.setTitle(title: "방 목록")
            
            ourMemoryCtl = CtlMaker().createDataControllerWithContract(contract: .eContractOurMemory, view: self, data: data) as? OurMemoryContract
            roomsAdapter.setCollection(collectionView: roomsCollectionView)
            ourMemoryCtl?.setCollectionWithAdpater(adapter: roomsAdapter)
            
            
            roomsCollectionView.registCell(cellIdentifier: NoItemCollectionViewCell.className())
            roomsCollectionView.registCell(cellIdentifier: SearchCollectionViewCell.className())
            roomsCollectionView.registCell(cellIdentifier: OurMemoryRoomsCollectionViewCell.className())
            let roomsTapGs = UITapGestureRecognizer(target: self, action:#selector(closeTabbar(sender:)))
            roomsTapGs.numberOfTapsRequired = 1
            roomsCollectionView.addGestureRecognizer(roomsTapGs)
            let topTapGs = UITapGestureRecognizer(target: self, action:#selector(closeTabbar(sender:)))
            topTapGs.numberOfTapsRequired = 1
            self.topView.addGestureRecognizer(topTapGs)
            let searchTapGs = UITapGestureRecognizer(target: self, action:#selector(closeTabbar(sender:)))
            searchTapGs.numberOfTapsRequired = 1
            searchFreindSettingBtnContainer.addGestureRecognizer(searchTapGs)

            if let ctl = self.getDataContract() as? OurMemoryContract {
                self.addFriendsAndAddRoomsBtn.addAction { p1 in
                    ctl.actionAddRoomBtn(sender: p1 as! UIButton)
                }
                
                self.searchBtn.addAction { p1 in
                    ctl.actionSearchBtn(sender: p1 as! UIButton)
                }
                
                self.settingsBtn.addAction { p1 in
                    ctl.actionSettingsBtn(sender: p1 as! UIButton)
                }
            }
            
        } else {
            guard let ctl = self.getDataContract() as? OurMemoryContract else { return }
            ctl.reloadView()
            
        }
        
        
    }
    
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tabbar.updateTabViewState(open: false)
        super.touchesBegan(touches, with: event)
    }
}

extension OurMemoryViewController:OurMemoryView {
    
    func setTabbarView(tabView:UIView) {
        if let tabbar = tabView as? TabbarView {
            self.tabbar = tabbar
            self.view.addSubview(tabView)
        }
    }
    
    @objc func closeTabbar(sender: UITapGestureRecognizer) {
        self.tabbar.updateTabViewState(open: false)
    }
    
    func updateNotiCnt(items:[UInt:Int]) {
        
    }
    
}


extension OurMemoryViewController: OurMemoryRoomsTabView {

    
    
}
