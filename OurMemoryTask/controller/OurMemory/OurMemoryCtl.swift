//
//  OurMemoryCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/20.
//

import UIKit

class OurMemoryCtl: BaseCtl {

    enum OURMEMORY_TAB {
        case FRIENDSTAB
        case ROOMSTAB
        case unowned
        
    }
    
    var currenctTab:OURMEMORY_TAB = .unowned
    
    override func __initWithData__(data: Any?) {
        
    }
}

extension OurMemoryCtl: OurMemoryContract {
    
    func switchFriendsTab() {
        if currenctTab == .FRIENDSTAB { return }
        currenctTab = .FRIENDSTAB
        if let view = self.view as? OurMemoryView {
            view.activeFriendsTabView()
        }
    }
    
    func switchRoomsTab() {
        if currenctTab == .ROOMSTAB { return }
        currenctTab = .ROOMSTAB
        if let view = self.view as? OurMemoryView {
            view.activeRoomsTabView()
        }
    }
    
    func reloadView() {
        switch self.currenctTab {
        case .FRIENDSTAB:
            if let view = self.view as? OurMemoryView {
                view.activeFriendsTabView()
            }
            break
        case .ROOMSTAB:
            if let view = self.view as? OurMemoryView {
                view.activeRoomsTabView()
            }
            break
        default:
            break
        }
    }
    
    func actionSearchBtn(sender: UIButton) {
        if let view = self.view as? OurMemoryView {
            view.updateSearchView()
        }
    }
    
    func actionAddFriendAndAddRoomBtn(sender: UIButton) {
        switch currenctTab {
        case .unowned:
            break
        case .ROOMSTAB:
            if let view = self.view as? OurMemoryView {
                view.showNextVC(vc: .NEXTVIEW_ADDROOMS, data: nil)
            }
            break
        case .FRIENDSTAB:
            if let view = self.view as? OurMemoryView {
                view.showNextVC(vc: .NEXTVIEW_ADDFRIENDS, data: nil)
            }
            break
        }
        
    }
    
    func actionSettingsBtn(sender: UIButton) {
        
    }
    
    
}
