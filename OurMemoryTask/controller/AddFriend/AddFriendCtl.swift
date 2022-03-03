//
//  AddFriendCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import UIKit



class AddFriendCtl: BaseCollectionCtl {
    
    enum ADDFRIENDTAB:Int {
        
        case RECOMMEND
        case QR
        case ID
        case NAME
        
    }
    
    var currentTab:ADDFRIENDTAB = .RECOMMEND
    
    
    override func __initWithData__(data: Any?) {
        
    }
    
}

extension AddFriendCtl: AddFriendContract {
    
    func switchFriendsSearchForRecommendTab() {
        currentTab = .RECOMMEND
        if let view = self.view as? AddFriendsView {
            view.updateSelectTabIndex(idx:currentTab.rawValue)
        }
    }
    
    func switchFriendsSearchForQRTab() {
        currentTab = .QR
        if let view = self.view as? AddFriendsView {
            view.updateSelectTabIndex(idx:currentTab.rawValue)
        }
    }
    
    func switchFriendsSearchForIDTab() {
        currentTab = .ID
        if let view = self.view as? AddFriendsView {
            view.updateSelectTabIndex(idx:currentTab.rawValue)
            view.updateUserListAtSearchID()
        }
    }
    
    func switchFriendsSearchForNameTab() {
        currentTab = .NAME
        if let view = self.view as? AddFriendsView {
            view.updateSelectTabIndex(idx:currentTab.rawValue)
            view.updateUserListAtSearchName()
        }
    }
}
