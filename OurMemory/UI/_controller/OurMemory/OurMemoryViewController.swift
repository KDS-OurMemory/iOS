//
//  OurMemoryViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit
import OurMemoryTask

class OurMemoryViewController: BaseViewController {

    var ourMemoryCtl:OurMemoryContract?
    @IBOutlet weak var tabViewContainer: UIView!
    @IBOutlet weak var searchFreindSettingBtnContainer: UIView!
    @IBOutlet weak var freindView: BaseView!
    @IBOutlet weak var roomView: BaseView!
    let tabView:FreindAndRoomTabbarView = FreindAndRoomTabbarView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: topViewHeight))
    var tabbar:TabbarView!
    
    override func getDataContract() -> DataContract? {
        return self.ourMemoryCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            ourMemoryCtl = CtlMaker().createDataControllerWithContract(contract: .eContractOurMemory, view: self, data: data) as? OurMemoryContract
        }
        
        tabViewContainer.addSubview(tabView)
        tabView.setSelectTabBlock { p1 in
            switch p1 {
            case .SELECT_ROOMTAB:
                break
            case .SELECT_FREINDTAB:
                break
            }
        }
    }

}

extension OurMemoryViewController:OurMemoryView {
    
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
    
    func updateFriendList() {
        
    }
    
    func updateRoomList() {
        
    }
    
    
}
